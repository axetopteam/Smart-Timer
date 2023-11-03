import '../workout_interval_type.dart';

sealed class TimerStatus {
  abstract final String name;
}

class ReadyStatus extends TimerStatus {
  @override
  final String name = 'ready';
}

class RunStatus extends TimerStatus {
  @override
  final String name = 'run';

  RunStatus({
    required this.time,
    required this.type,
    this.totalDuration,
  });

  final Duration time;
  final IntervalType type;
  final Duration? totalDuration;

  double? get shareOfTotalDuration {
    final currentIntervalDurationInMilliseconds = totalDuration?.inMilliseconds;
    return currentIntervalDurationInMilliseconds != null
        ? (currentIntervalDurationInMilliseconds - time.inMilliseconds) / currentIntervalDurationInMilliseconds
        : null;
  }
}

class PauseStatus extends TimerStatus {
  @override
  final String name = 'pause';

  PauseStatus({
    required this.time,
    required this.type,
    this.totalDuration,
  });

  final Duration time;
  final IntervalType type;
  final Duration? totalDuration;
}

class DoneStatus extends TimerStatus {
  @override
  final String name = 'done';
}
