import 'package:protobuf/protobuf.dart';
import 'package:smart_timer/timer/timer_type.dart';
export 'package:smart_timer/timer/timer_type.dart';

class FavoriteWorkout {
  final int id;
  final String name;
  final String description;
  final GeneratedMessage workoutSettings;
  final TimerType timerType;

  FavoriteWorkout({
    required this.id,
    required this.name,
    required this.description,
    required this.workoutSettings,
    required this.timerType,
  });
}
