import 'package:smart_timer/sdk/models/protos/workout_settings/workout_settings.pb.dart';

export 'package:smart_timer/sdk/models/protos/workout_settings/workout_settings.pb.dart';
export 'package:smart_timer/timer/timer_type.dart';

class FavoriteWorkout {
  final int id;
  final String name;
  final String description;
  final WorkoutSettings workoutSettings;

  FavoriteWorkout({
    required this.id,
    required this.name,
    required this.description,
    required this.workoutSettings,
  });
}
