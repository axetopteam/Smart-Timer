import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/sdk/models/protos/amrap/amrap_extension.dart';
import 'package:smart_timer/sdk/models/protos/amrap_settings/amrap_settings.pbserver.dart';
import 'package:smart_timer/sdk/sdk_service.dart';

import '../timer_settings_interface.dart';

part 'amrap_state.g.dart';

class AmrapState = AmrapStateBase with _$AmrapState implements TimerSettingsInterface;

abstract class AmrapStateBase with Store {
  AmrapStateBase({List<Amrap>? amraps}) : amraps = ObservableList.of(amraps ?? [AmrapX.defaultValue]);

  final type = TimerType.amrap;

  ObservableList<Amrap> amraps;

  @computed
  int get amrapsCount => amraps.length;

  @action
  void setWorkTime(int amrapIndex, Duration duration) {
    if (amrapIndex < 0 || amrapIndex >= amrapsCount) return;

    amraps[amrapIndex] = amraps[amrapIndex].copyWithNewValue(workTime: duration);
  }

  @action
  void setRestTime(int amrapIndex, Duration duration) {
    if (amrapIndex < 0 || amrapIndex >= amrapsCount) return;

    amraps[amrapIndex] = amraps[amrapIndex].copyWithNewValue(restTime: duration);
    if (amrapIndex == amrapsCount - 2) {
      amraps[amrapIndex + 1] = amraps[amrapIndex + 1].copyWithNewValue(restTime: duration);
    }
  }

  @action
  void addAmrap() {
    final lastAmrapCopy = amraps.last.copyWithNewValue();
    amraps.add(lastAmrapCopy);
  }

  @action
  void deleteAmrap(int amrapIndex) {
    amraps.removeAt(amrapIndex);
  }

  Future<void> saveToFavorites({required String name, required String description}) async {
    return GetIt.I<SdkService>().addToFavorite(
      settings: settings,
      name: name,
      description: description,
    );
  }

  @computed
  Workout get workout {
    final List<Interval> intervals = [];

    for (int i = 0; i < amrapsCount; i++) {
      final setIndex = IntervalIndex(index: i, localeKey: LocaleKeys.amrap_title, totalCount: amrapsCount);

      final workInterval = FiniteInterval(
        duration: amraps[i].workTime,
        isReverse: true,
        activityType: ActivityType.work,
        isLast: amrapsCount > 1 && i == amrapsCount - 1,
        indexes: [setIndex],
      );
      final restInterval = FiniteInterval(
        duration: amraps[i].restTime,
        isReverse: true,
        activityType: ActivityType.rest,
        indexes: [setIndex],
      );
      intervals.addAll([
        workInterval,
        if (i != amrapsCount - 1) restInterval,
      ]);
    }

    return Workout(intervals: intervals);
  }

  @computed
  WorkoutSettings get settings => WorkoutSettings(amrap: AmrapSettings(amraps: amraps));
}
