import 'package:smart_timer/UI/timer/timer_type.dart';
import 'package:smart_timer/sdk/models/protos/workout_settings/workout_settings.pb.dart';
import 'package:smart_timer/sdk/models/protos/workout_settings/workout_settings_extension.dart';
import 'package:smart_timer/sdk/models/results/result_interface.dart';
import 'package:smart_timer/sdk/models/results/workout_result.dart';
import 'package:smart_timer/utils/duration.extension.dart';

export 'package:smart_timer/UI/timer/timer_type.dart';

class TrainingHistoryRecord {
  final int id;
  final DateTime finishAt;
  final String name;
  final String description;
  final int? wellBeing;
  final WorkoutSettings workout;
  final TimerType timerType;
  final WorkoutResultInterface result;
  final bool isCompleted;

  TrainingHistoryRecord({
    required this.id,
    required this.finishAt,
    required this.name,
    required this.description,
    this.wellBeing,
    required this.workout,
    required this.timerType,
    required this.result,
    required this.isCompleted,
  });

  String get readbleName {
    if (name.isNotEmpty) {
      return name;
    } else {
      final result = this.result;
      final count = result is WorkoutResult ? result.sets.length : 1;
      return '${count != 1 ? '${count}x' : ''}${timerType.readbleName}: ${result.totalDuration.durationToString()}';
    }
  }
}
