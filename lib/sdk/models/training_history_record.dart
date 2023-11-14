import 'package:smart_timer/UI/timer/timer_type.dart';
import 'package:smart_timer/sdk/models/protos/workout_settings/workout_settings.pb.dart';
import 'package:smart_timer/sdk/models/protos/workout_settings/workout_settings_extension.dart';
import 'package:smart_timer/sdk/models/workout/interval.dart';

export 'package:smart_timer/sdk/models/workout/interval.dart';

class TrainingHistoryRecord {
  final int id;
  final DateTime startAt;
  final DateTime endAt;
  final String name;
  final String description;
  final int? wellBeing;
  final WorkoutSettings workout;
  final TimerType timerType;
  final List<Interval> intervals;

  TrainingHistoryRecord({
    required this.id,
    required this.startAt,
    required this.endAt,
    required this.name,
    required this.description,
    this.wellBeing,
    required this.workout,
    required this.timerType,
    required this.intervals,
  });

  String get readbleName {
    return name;
    if (name.isNotEmpty) {
      return name;
    } else {
      // final count = results is WorkoutResult ? result.sets.length : 1;
      // return '${count != 1 ? '${count}x' : ''}${timerType.readbleName}: ${result.totalDuration.durationToString()}';
    }
  }
}
