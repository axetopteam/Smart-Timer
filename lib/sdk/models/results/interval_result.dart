import '../workout_interval_type.dart';
import 'result_interface.dart';
export '../workout_interval_type.dart';

class IntervalResult implements WorkoutResultInterface {
  IntervalResult({
    required this.type,
    required this.duration,
    required this.currentDuration,
    required this.isCompleted,
  });
  final WorkoutIntervalType type;
  final Duration? duration;
  final Duration? currentDuration;
  final bool isCompleted;

  @override
  Duration get totalDuration {
    return (duration ?? currentDuration) ?? const Duration();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': WorkoutResultType.interval.name,
      'data': {
        'type': type.name,
        if (duration != null) 'duration': duration!.inSeconds,
        if (currentDuration != null) 'currentDuration': currentDuration!.inSeconds,
        'isCompleted': isCompleted,
      },
    };
  }

  factory IntervalResult.fromJson(Map<String, dynamic> json) {
    final type = WorkoutIntervalType.values.firstWhere((element) => element.name == json['type']);
    final duration = json['duration'] != null ? Duration(seconds: json['duration']) : null;
    final currentDuration = json['currentDuration'] != null ? Duration(seconds: json['currentDuration']) : null;
    final isCompleted = json['isCompleted'] ?? json['isEnded'];
    return IntervalResult(type: type, duration: duration, currentDuration: currentDuration, isCompleted: isCompleted);
  }
}
