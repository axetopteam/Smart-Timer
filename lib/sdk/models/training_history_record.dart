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
  final List<Interval> _intervals;
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
    required List<Interval> intervals,
    required this.pauses,
  }) : _intervals = intervals;

  Duration get realDuration {
    var countdownDuration = Duration.zero;
    final firstInterval = _intervals.first;
    if (firstInterval.activityType == ActivityType.countdown && firstInterval.totalDuration != null) {
      countdownDuration = firstInterval.totalDuration!;
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

  Duration? durationAtEndOfInterval(int index) {
    final endIndex = (index + 1).clamp(0, intervalsWithoutCountdown.length);
    return intervalsWithoutCountdown.getRange(0, endIndex).toList().totalDuration;
  }

  List<Interval> get intervalsWithoutCountdown {
    if (_intervals.firstOrNull?.activityType == ActivityType.countdown) {
      return _intervals.getRange(1, _intervals.length).toList();
    }
    return _intervals;
  }

  Duration sumPauseToTime(DateTime time) {
    //предполагается что паузы отсортированы

    var pauseDuration = Duration.zero;
    for (var pause in pauses) {
      if (pause.startAt.isBefore(time)) {
        break;
      }
      final endTime = time.isBefore(pause.endAt!) ? time : pause.endAt!;
      final duration = endTime.difference(pause.startAt);
      pauseDuration += duration;
    }
    return pauseDuration;
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
