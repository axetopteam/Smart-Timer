import 'package:smart_timer/UI/timer/timer_type.dart';
import 'package:smart_timer/sdk/models/protos/workout_settings/workout_settings_extension.dart';

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

  String get readbleName {
    return name.isNotEmpty ? name : workoutSettings.name;
  }

  String get readbleDescription {
    return description.isNotEmpty ? description : workoutSettings.description;
  }
}
