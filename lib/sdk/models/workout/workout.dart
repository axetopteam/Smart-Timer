import 'package:equatable/equatable.dart';
import 'package:smart_timer/services/audio_service.dart';

import '../workout_interval_type.dart';
import 'interval.dart';
import 'interval_info.dart';

export 'interval.dart';
export 'interval_info.dart';

typedef DescriptionSolver = String Function(int index);

class Workout extends Equatable {
  const Workout({
    required this.intervals,
    this.pauses = const [],
    this.startTime,
  });

  final List<Interval> intervals;
  final DateTime? startTime;
  final List<Pause> pauses;

  Workout addCountdown(Duration duration) {
    final countdownInterval = FiniteInterval(
      type: IntervalType.countdown,
      duration: duration,
      indexes: [],
    );
    return copyWith(intervals: [countdownInterval, ...intervals]);
  }

  bool get hasCountdownInterval {
    final countdownInterval = intervals.firstOrNull;
    return countdownInterval != null &&
        countdownInterval is FiniteInterval &&
        countdownInterval.type == IntervalType.countdown;
  }

  bool isCountdownCompleted({required DateTime now}) {
    final countdownInterval = intervals.firstOrNull;
    final start = startTime;
    if (start != null && hasCountdownInterval) {
      return countdownInterval!.currentTime(startTime: start, now: now) < Duration.zero;
    }
    return false;
  }

  Duration? get totalDuration {
    var sum = Duration.zero;
    for (var interval in intervals) {
      final totalDuration = interval.totalDuration;
      if (totalDuration == null) return null;
      sum += totalDuration;
    }
    return sum;
  }

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

  Workout reset() {
    return Workout(intervals: intervals);
  }

  Workout copyWith({List<Interval>? intervals, DateTime? startTime, List<Pause>? pauses}) {
    return Workout(
      intervals: intervals ?? this.intervals,
      startTime: startTime ?? this.startTime,
      pauses: pauses ?? this.pauses,
    );
  }

  @override
  List<Object?> get props => [intervals, startTime, pauses];
}

class WorkoutCalculator {
  static TimerStatus currentIntervalInfo({
    required DateTime now,
    required Workout workout,
    bool completeCurrentInterval = false,
  }) {
    var startTime = workout.startTime;
    if (startTime == null) {
      return ReadyStatus();
    }

    var pauseDuration = Duration.zero;
    for (var element in workout.pauses) {
      pauseDuration += element.getDuration(now);
    }
    print('pause: $pauseDuration');

    startTime = startTime.add(pauseDuration);

    for (var index = 0; index < workout.intervals.length; index++) {
      if (index > 0 && workout.intervals[index] is RepeatLastInterval) {
        final previousInterval = workout.intervals[index - 1];
        final previousIntervalIndexes = List.of(previousInterval.indexes);
        previousIntervalIndexes.last = previousIntervalIndexes.last.copyWith(index);
        workout = workout.copyWith(
          intervals: workout.intervals
            ..insert(
              index,
              previousInterval.copyWith(indexes: previousIntervalIndexes),
            ),
        );
      }
      var interval = workout.intervals[index];
      final nextInterval = index + 1 < workout.intervals.length ? workout.intervals[index + 1] : null;

      final time = interval.currentTime(
        startTime: startTime!,
        now: now,
      );

      if (time >= Duration.zero) {
        if (completeCurrentInterval) {
          final completedInterval = TimeCapInterval(
            timeCap: time,
            type: interval.type,
            isLast: interval.isLast,
            indexes: interval.indexes,
          );
          final newIntervals = workout.intervals;
          newIntervals[index] = completedInterval;

          if (nextInterval != null && nextInterval is RatioInterval) {
            final newNext = FiniteInterval(
              duration: time * nextInterval.ratio,
              type: nextInterval.type,
              indexes: nextInterval.indexes,
              isLast: nextInterval.isLast,
            );
            newIntervals[index + 1] = newNext;
          } else if (nextInterval != null && nextInterval is RepeatLastInterval) {
            newIntervals.removeAt(index + 1);
          }

          workout = workout.copyWith(intervals: newIntervals);

          interval = completedInterval;
          completeCurrentInterval = false;
        } else {
          final status = RunStatus(
            time: time,
            type: interval.type,
            totalDuration: interval.totalDuration,
            soundType: _checkSound(interval, time),
            indexes: interval.indexes,
            canBeCompleted: interval is! FiniteInterval || nextInterval != null && nextInterval is RepeatLastInterval,
          );
          return status;
        }
      }
      switch (interval) {
        case FiniteInterval():
          startTime = startTime.add(interval.duration);
        case TimeCapInterval():
          startTime = startTime.add(interval.timeCap);
        case InfiniteInterval():
        case RatioInterval():
        case RepeatLastInterval():
          throw TypeError();
      }
    }
    return DoneStatus();
  }

  static const _threeSeconds = Duration(seconds: 3);
  static const _tenSeconds = Duration(seconds: 10);
  static const _delta = Duration(milliseconds: 100);

  static SoundType? _checkSound(Interval interval, Duration time) {
    switch (interval) {
      case FiniteInterval():
        if (interval.totalDuration! > _threeSeconds && time == _threeSeconds) {
          return SoundType.countdown;
        }
        if (interval.totalDuration! > _tenSeconds && time == _tenSeconds) {
          return SoundType.tenSeconds;
        }
        if (interval.isLast && interval.totalDuration! - _delta == time) {
          return SoundType.lastRound;
        }
      case TimeCapInterval():
        if (interval.totalDuration! > _threeSeconds && interval.totalDuration! - _threeSeconds == time) {
          return SoundType.countdown;
        }
        if (interval.totalDuration! > _tenSeconds && interval.totalDuration! - _tenSeconds == time) {
          return SoundType.tenSeconds;
        }
        if (interval.isLast && time == Duration.zero + _delta) {
          return SoundType.lastRound;
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

class Pause {
  Pause({
    required this.startAt,
    this.endAt,
  });
  final DateTime startAt;
  final DateTime? endAt;

  bool get isEnded => endAt != null;

  Duration getDuration(DateTime now) {
    return (endAt ?? now).toUtc().difference(startAt.toUtc());
  }

  Pause endPause(DateTime time) {
    return Pause(startAt: startAt, endAt: time);
  }
}
