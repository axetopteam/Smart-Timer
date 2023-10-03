import 'package:smart_timer/sdk/models/protos/workout_settings/workout_settings.pb.dart';
import 'package:smart_timer/UI/timer/timer_type.dart';

export 'package:smart_timer/sdk/models/protos/workout_settings/workout_settings.pb.dart';
export 'package:smart_timer/UI/timer/timer_type.dart';

class FavoriteWorkout {
  final int id;
  final String name;
  final String description;
  final TimerType type;
  final WorkoutSettings workoutSettings;

  FavoriteWorkout({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.workoutSettings,
  });
}
