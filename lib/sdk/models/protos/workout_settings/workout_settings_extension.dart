import 'workout_settings.pb.dart';

export 'workout_settings.pb.dart';

extension WorkoutSettingsX on WorkoutSettings {
  String get description {
    switch (whichWorkout()) {
      case WorkoutSettings_Workout.amrap:
        final amraps = amrap.amraps.map((e) => e.toString());
        return 'AMRAP $amraps';
      case WorkoutSettings_Workout.afap:
        return 'AMRAP';
      case WorkoutSettings_Workout.emom:
        return 'AMRAP';
      case WorkoutSettings_Workout.tabata:
        return 'AMRAP';
      case WorkoutSettings_Workout.workRest:
        return 'AMRAP';
      case WorkoutSettings_Workout.notSet:
        return '';
    }
  }
}
