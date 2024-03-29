import 'package:smart_timer/sdk/models/training_history_record.dart';
import 'package:smart_timer/services/audio_service.dart';

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
    required this.isReverse,
  });

  final Duration time;
  final ActivityType type;
  final Duration? totalDuration;
  final SoundType? soundType;
  final bool canBeCompleted;
  final bool isReverse;

  double get shareOfTotalDuration {
    final currentIntervalDurationInMilliseconds = totalDuration?.inMilliseconds;
    if (currentIntervalDurationInMilliseconds != null) {
      return isReverse
          ? (currentIntervalDurationInMilliseconds - time.inMilliseconds) / currentIntervalDurationInMilliseconds
          : (time.inMilliseconds) / currentIntervalDurationInMilliseconds;
    }
    return 0.0;
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
    required this.isReverse,
  });

  final Duration time;
  final ActivityType type;
  final Duration? totalDuration;
  final bool isReverse;
}

class DoneStatus extends TimerStatus {
  DoneStatus({this.result}) : super();

  final TrainingHistoryRecord? result;

  @override
  final String name = 'done';
}
