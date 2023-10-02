import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/sdk/models/protos/amrap/amrap_extension.dart';
import 'package:smart_timer/timer_types/afap/afap_state.dart';
import 'package:smart_timer/utils/string_utils.dart';

import 'workout_settings.pb.dart';

export 'workout_settings.pb.dart';

extension WorkoutSettingsX on WorkoutSettings {
  String get description {
    switch (whichWorkout()) {
      case WorkoutSettings_Workout.amrap:
        final buffer = StringBuffer();
        amrap.amraps.forEachIndexed(
          (index, element) {
            buffer.write(element.workTime.readableString);
            if (index != amrap.amraps.length - 1) {
              buffer.writeAll(['/', element.restTime.readableString, '/']);
            }
          },
        );
        return '${LocaleKeys.amrap_title.tr()}: $buffer';
      case WorkoutSettings_Workout.afap:
        final buffer = StringBuffer();
        afap.afaps.forEachIndexed(
          (index, element) {
            if (element.noTimeCap) {
              buffer.write('No cap');
            } else {
              buffer.write(element.timeCap.readableString);
            }
            if (index != afap.afaps.length - 1) {
              buffer.writeAll(['/', element.restTime.readableString, '/']);
            }
          },
        );
        return '${LocaleKeys.afap_title.tr()}: $buffer';
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
