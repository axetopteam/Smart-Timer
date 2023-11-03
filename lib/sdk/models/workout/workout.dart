import 'package:equatable/equatable.dart';

import '../workout_interval_type.dart';
import 'interval.dart';
import 'interval_info.dart';

export 'interval.dart';
export 'interval_info.dart';

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
    );
    return copyWith(intervals: [countdownInterval, ...intervals]);
  }

  bool isCountdownCompleted({required DateTime now}) {
    final countdownInterval = intervals.firstOrNull;
    final start = startTime;
    if (start != null &&
        countdownInterval != null &&
        countdownInterval is FiniteInterval &&
        countdownInterval.type == IntervalType.countdown) {
      return countdownInterval.currentTime(startTime: start, now: now) == Duration.zero;
    }
    return false;
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
    required DateTime startTime,
    required DateTime now,
    required List<Interval> intervals,
    required List<Pause> pauses,
  }) {
    var pauseDuration = Duration.zero;
    for (var element in pauses) {
      pauseDuration += element.getDuration(now);
    }
    print('pause: $pauseDuration');

    startTime = startTime.add(pauseDuration);
    for (var interval in intervals) {
      final time = interval.currentTime(
        startTime: startTime,
        now: now,
      );
      if (time.inMilliseconds > 0) {
        final status = RunStatus(
          time: time,
          type: interval.type,
          totalDuration: interval.totalDuration,
        );
        print('#WorkoutCalculator# ${status.time}, ${status.totalDuration}, ${status.shareOfTotalDuration}}');
        return status;
      }
      switch (interval) {
        case FiniteInterval():
          startTime = startTime.add(interval.duration);
        case TimeCapInterval():
          startTime = startTime.add(interval.timeCap);
        case InfiniteInterval():
          throw TypeError();
      }
    }
    return DoneStatus();
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
