import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/sdk/models/protos/amrap/amrap_extension.dart';
import 'package:smart_timer/UI/timer_types/afap/afap_state.dart';
import 'package:smart_timer/UI/timer_types/emom/emom_state.dart';
import 'package:smart_timer/UI/timer_types/tabata/tabata_state.dart';
import 'package:smart_timer/utils/duration.extension.dart';

import 'workout_settings.pb.dart';

export 'workout_settings.pb.dart';

extension WorkoutSettingsX on WorkoutSettings {
  String get name {
    switch (whichWorkout()) {
      case WorkoutSettings_Workout.amrap:
        final amrapsCount = amrap.amraps.length > 1 ? '${amrap.amraps.length}x' : '';
        return '$amrapsCount${LocaleKeys.amrap_title.tr()}';
      case WorkoutSettings_Workout.afap:
        final afapsCount = afap.afaps.length > 1 ? '${afap.afaps.length}x' : '';
        return '$afapsCount${LocaleKeys.afap_title.tr()}';
      case WorkoutSettings_Workout.emom:
        final emomsCount = emom.emoms.length > 1 ? '${emom.emoms.length}x' : '';
        return '$emomsCount${LocaleKeys.emom_title.tr()}';
      case WorkoutSettings_Workout.tabata:
        final tabatsCount = tabata.tabats.length > 1 ? '${tabata.tabats.length}x' : '';
        return '$tabatsCount${LocaleKeys.tabata_title.tr()}';
      case WorkoutSettings_Workout.workRest:
        final setsCount = workRest.workRests.length > 1 ? '${workRest.workRests.length}x' : '';
        return '$setsCount${LocaleKeys.work_rest_title.tr()}';
      case WorkoutSettings_Workout.notSet:
        return '';
    }
  }

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
        return buffer.toString();
      case WorkoutSettings_Workout.afap:
        final buffer = StringBuffer();
        afap.afaps.forEachIndexed(
          (index, element) {
            if (element.noTimeCap) {
              buffer.write(LocaleKeys.no_cap.tr());
            } else {
              buffer.write(element.timeCap.readableString);
            }
            if (index != afap.afaps.length - 1) {
              buffer.writeAll(['/', element.restTime.readableString, '/']);
            }
          },
        );
        return '$buffer';
      case WorkoutSettings_Workout.emom:
        final buffer = StringBuffer();
        emom.emoms.forEachIndexed(
          (index, element) {
            buffer.writeAll([
              '${element.roundsCount}x',
              element.workTime.readableString,
            ]);
            if (index != emom.emoms.length - 1) {
              buffer.writeAll(['/', element.restAfterSet.readableString, '/']);
            }
          },
        );
        return '$buffer';
      case WorkoutSettings_Workout.tabata:
        final buffer = StringBuffer();
        tabata.tabats.forEachIndexed(
          (index, element) {
            buffer.writeAll([
              '${element.roundsCount}x',
              '(',
              element.workTime.readableString,
              '/',
              element.restTime.readableString,
              ')',
            ]);
            if (index != tabata.tabats.length - 1) {
              buffer.writeAll(['/', element.restAfterSet.readableString, '/']);
            }
          },
        );
        return '$buffer';
      case WorkoutSettings_Workout.workRest:
        final buffer = StringBuffer();
        workRest.workRests.forEachIndexed(
          (index, element) {
            double ratioFraction = element.ratio - element.ratio.truncate();
            final ratio = ratioFraction == 0 ? element.ratio.toInt() : element.ratio;

            buffer.writeAll([
              '${element.roundsCount}x',
              '(',
              '1:$ratio',
              ')',
            ]);
          },
        );
        return '$buffer';
      case WorkoutSettings_Workout.notSet:
        return '';
    }
  }
}
