import 'package:smart_timer/UI/timer/timer_type.dart';
import 'package:smart_timer/sdk/models/protos/workout_settings/workout_settings.pb.dart';
import 'package:smart_timer/sdk/models/workout/workout.dart';

export 'package:smart_timer/sdk/models/workout/workout.dart';

abstract class TimerSettingsInterface {
  Workout get workout;

  WorkoutSettings get settings;

  abstract final TimerType type;
}
