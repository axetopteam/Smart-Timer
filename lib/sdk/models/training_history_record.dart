import 'package:smart_timer/UI/timer/timer_type.dart';
import 'package:smart_timer/sdk/models/protos/workout_settings/workout_settings.pb.dart';
import 'package:smart_timer/sdk/models/results/result_interface.dart';

export 'package:smart_timer/UI/timer/timer_type.dart';

class TrainingHistoryRecord {
  final int id;
  final DateTime dateTime;
  final String name;
  final String description;
  final int? wellBeing;
  final WorkoutSettings workout;
  final TimerType timerType;
  final WorkoutResultInterface result;

  TrainingHistoryRecord({
    required this.id,
    required this.dateTime,
    required this.name,
    required this.description,
    this.wellBeing,
    required this.workout,
    required this.timerType,
    required this.result,
  });
}
