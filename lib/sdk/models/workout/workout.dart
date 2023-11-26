import 'package:equatable/equatable.dart';
import 'package:smart_timer/services/audio_service.dart';

import 'interval.dart';
import 'pause.dart';

export 'interval.dart';
export 'interval_info.dart';
export 'pause.dart';

class Workout extends Equatable {
  Workout({
    required List<Interval> intervals,
    this.pauses = const [],
    this.startTime,
    this.endTime,
  }) : intervals = List.unmodifiable(intervals);

  final List<Interval> intervals;
  final DateTime? startTime;
  final DateTime? endTime;
  final List<Pause> pauses;

  Workout addCountdown(Duration duration) {
    final countdownInterval = FiniteInterval(
      activityType: ActivityType.countdown,
      isReverse: true,
      duration: duration,
      indexes: [],
    );
    return copyWith(intervals: [countdownInterval, ...intervals]);
  }

  bool get hasCountdownInterval {
    final countdownInterval = intervals.firstOrNull;
    return countdownInterval != null &&
        countdownInterval is FiniteInterval &&
        countdownInterval.activityType == ActivityType.countdown;
  }

  bool isCountdownCompleted({required DateTime now}) {
    final countdownInterval = intervals.firstOrNull;
    final start = startTime;
    if (start != null && hasCountdownInterval) {
      return countdownInterval!.currentTime(startTime: start, now: now) < Duration.zero;
    }
    return false;
  }

  Duration? get totalDuration => intervals.totalDuration;

  Workout startPause(DateTime time) {
    final lastPause = pauses.lastOrNull;
    if (lastPause?.isEnded ?? true) {
      final pause = Pause(startAt: time.toUtc());
      return copyWith(pauses: [...pauses, pause]);
    }
    return this;
  }

  Workout endPause(DateTime time) {
    final lastPause = pauses.lastOrNull;
    if (!(lastPause?.isEnded ?? true)) {
      final pause = lastPause!.endPause(time.toUtc());
      pauses.last = pause;
      return copyWith(pauses: pauses);
    }
    return this;
  }

  Workout setEndTime(DateTime dateTime) {
    if (endTime != null) return this;
    final workout = endPause(dateTime);
    return workout.copyWith(endTime: dateTime);
  }

  Workout reset() {
    return Workout(intervals: intervals);
  }

  Workout copyWith({List<Interval>? intervals, DateTime? startTime, DateTime? endTime, List<Pause>? pauses}) {
    return Workout(
      intervals: intervals ?? this.intervals,
      startTime: startTime ?? this.startTime,
      pauses: pauses ?? this.pauses,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  List<Object?> get props => [intervals, startTime, pauses];
}

extension IntervalsList on List<Interval> {
  Duration? get totalDuration {
    var sum = Duration.zero;
    for (var interval in this) {
      final totalDuration = interval.totalDuration;
      if (totalDuration == null) return null;
      sum += totalDuration;
    }
    return sum;
  }
}

class WorkoutCalculator {
  static (Duration?, Duration?, int) currentIntervalInfo({
    required DateTime now,
    required Workout workout,
  }) {
    var startTime = workout.startTime;
    if (startTime == null) {
      return (null, null, -1);
    }

    var start = startTime;

    var pauseDuration = Duration.zero;
    for (var pause in workout.pauses) {
      pauseDuration += pause.duration ?? (now.toUtc().difference(pause.startAt));
    }

    start = start.add(pauseDuration);

    for (var index = 0; index < workout.intervals.length; index++) {
      var interval = workout.intervals[index];

      final time = interval.currentTime(
        startTime: start,
        now: now,
      );
      final pastTime = interval.pastTime(
        startTime: start,
        now: now,
      );

      if (time >= Duration.zero) {
        return (time, pastTime, index);
      }

      switch (interval) {
        case FiniteInterval():
          start = start.add(interval.duration);
        case InfiniteInterval():
        case RatioInterval():
        case RepeatLastInterval():
          return (null, null, index);
      }
    }

    return (null, null, workout.intervals.length);
  }

  static const _threeSeconds = Duration(seconds: 3);
  static const _tenSeconds = Duration(seconds: 10);
  static const _delta = Duration(milliseconds: 100);

  static bool checkCanBeCompleted(Interval interval) {
    return interval is! FiniteInterval || interval.canBeCompleteEarlier;
  }

  static SoundType? checkSound(Interval interval, Duration time) {
    switch (interval) {
      case FiniteInterval():
        if (interval.isReverse) {
          if (interval.duration > _threeSeconds && time == _threeSeconds) {
            return SoundType.countdown;
          }
          if (interval.duration > _tenSeconds && time == _tenSeconds) {
            return SoundType.tenSeconds;
          }
          if (interval.isLast && interval.duration - _delta == time) {
            return SoundType.lastRound;
          }
        } else {
          if (interval.duration > _threeSeconds && interval.duration - _threeSeconds == time) {
            return SoundType.countdown;
          }
          if (interval.duration > _tenSeconds && interval.duration - _tenSeconds == time) {
            return SoundType.tenSeconds;
          }
          if (interval.isLast && time == Duration.zero + _delta) {
            return SoundType.lastRound;
          }
        }

      case InfiniteInterval():
        if (interval.isLast && time == Duration.zero + _delta) {
          return SoundType.lastRound;
        }
      case RatioInterval():
      case RepeatLastInterval():
        break;
    }

    final totalDuration = interval.totalDuration;
    if (totalDuration != null && totalDuration > const Duration(seconds: 29)) {
      if (time == Duration(seconds: (totalDuration.inSeconds / 2).round())) {
        return SoundType.halfTime;
      }
    }

    return null;
    // if (finishTimeUtc != null) finishTimeUtc!.subtract(const Duration(seconds: 3)): SoundType.countdown;
  }
}
