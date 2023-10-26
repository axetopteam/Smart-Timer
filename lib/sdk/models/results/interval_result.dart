import '../workout_interval_type.dart';
import 'result_interface.dart';
export '../workout_interval_type.dart';

class IntervalResult implements WorkoutResultInterface {
  IntervalResult({
    required this.type,
    required this.duration,
    required this.isCompleted,
  });
  final WorkoutIntervalType type;
  final Duration? duration;
  final bool isCompleted;

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': WorkoutResultType.interval.name,
      'data': {
        'type': type.name,
        if (duration != null) 'duration': duration!.inSeconds,
        'isCompleted': isCompleted,
      },
    };
  }

  factory IntervalResult.fromJson(Map<String, dynamic> json) {
    final type = WorkoutIntervalType.values.firstWhere((element) => element.name == json['type']);
    final duration = json['duration'] != null ? Duration(seconds: json['duration']) : null;
    final isCompleted = json['isCompleted'] ?? json['isEnded'];
    return IntervalResult(type: type, duration: duration, isCompleted: isCompleted);
  }
}
