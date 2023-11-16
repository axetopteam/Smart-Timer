import 'package:smart_timer/UI/timer/timer_type.dart';
import 'package:smart_timer/UI/timer_types/timer_settings_interface.dart';
import 'package:smart_timer/sdk/models/protos/workout_settings/workout_settings.pb.dart';
import 'package:smart_timer/sdk/models/protos/workout_settings/workout_settings_extension.dart';

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
  final List<Pause> pauses;

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
    required this.pauses,
  });

  Duration get realDuration {
    var countdownDuration = Duration.zero;
    for (var interval in intervals) {
      if (interval.activityType == ActivityType.countdown && interval.totalDuration != null) {
        countdownDuration += interval.totalDuration!;
      }
    }
    return endAt.difference(startAt) - sumPause - countdownDuration;
  }

  Duration get sumPause {
    var result = Duration.zero;
    for (var pause in pauses) {
      result += pause.duration!;
    }
    return result;
  }

  String get readbleName {
    if (name.isNotEmpty) {
      return name;
    } else {
      final int? count;
      switch (workout.whichWorkout()) {
        case WorkoutSettings_Workout.amrap:
          count = workout.amrap.amraps.length;
        case WorkoutSettings_Workout.afap:
          count = workout.afap.afaps.length;
        case WorkoutSettings_Workout.emom:
          count = workout.emom.emoms.length;
        case WorkoutSettings_Workout.tabata:
          count = workout.tabata.tabats.length;
        case WorkoutSettings_Workout.workRest:
          count = workout.workRest.workRests.length;
        case WorkoutSettings_Workout.notSet:
          count = null;
      }

      return '${(count != null && count != 1) ? '${count}x' : ''}${timerType.readbleName}';
    }
  }
}
