import 'package:smart_timer/sdk/models/protos/workout_settings/workout_settings.pb.dart';
import 'package:smart_timer/UI/timer/timer_type.dart';

import 'workout_set.dart';

export 'package:smart_timer/sdk/models/protos/workout_settings/workout_settings.pb.dart';
export 'package:smart_timer/UI/timer/timer_type.dart';

class TrainingHistoryRecord {
  final int id;
  final DateTime dateTime;
  final String name;
  final String description;
  final int? wellBeing;
  final WorkoutSettings workout;
  final TimerType timerType;
  final WorkoutSet training;

  TrainingHistoryRecord({
    required this.id,
    required this.dateTime,
    required this.name,
    required this.description,
    this.wellBeing,
    required this.workout,
    required this.timerType,
    required this.training,
  });
}
