import 'package:smart_timer/services/audio_service.dart';

import '../workout_interval_type.dart';
import 'interval_index.dart';

sealed class TimerStatus {
  TimerStatus({this.indexes = const []});
  abstract final String name;
  final List<IntervalIndex> indexes;
}

class ReadyStatus extends TimerStatus {
  ReadyStatus({super.indexes});

  @override
  final String name = 'ready';
}

class RunStatus extends TimerStatus {
  @override
  final String name = 'run';

  RunStatus({
    required this.time,
    required this.type,
    super.indexes,
    required this.canBeCompleted,
    this.totalDuration,
    this.soundType,
  });

  final Duration time;
  final IntervalType type;
  final Duration? totalDuration;
  final SoundType? soundType;
  final bool canBeCompleted;

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
    super.indexes,
  });

  final Duration time;
  final IntervalType type;
  final Duration? totalDuration;
}

class DoneStatus extends TimerStatus {
  DoneStatus() : super();

  @override
  final String name = 'done';
}
