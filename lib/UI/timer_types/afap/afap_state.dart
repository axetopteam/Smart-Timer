import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/sdk/models/protos/afap/afap_extension.dart';
import 'package:smart_timer/sdk/models/protos/afap_settings/afap_settings.pb.dart';
import 'package:smart_timer/sdk/sdk_service.dart';

import '../timer_settings_interface.dart';

export 'package:smart_timer/sdk/models/protos/afap/afap_extension.dart';

part 'afap_state.g.dart';

class AfapState = AfapStateBase with _$AfapState implements TimerSettingsInterface;

abstract class AfapStateBase with Store {
  AfapStateBase({List<Afap>? afaps}) : afaps = ObservableList.of(afaps ?? [AfapX.defaultValue]);

  final type = TimerType.afap;

  ObservableList<Afap> afaps;

  @computed
  int get afapsCount => afaps.length;

  @action
  void setTimeCap(int afapIndex, Duration duration) {
    if (afapIndex < 0 || afapIndex >= afapsCount) return;

    afaps[afapIndex] = afaps[afapIndex].copyWithNewValue(timeCap: duration);
  }

  @action
  void setRestTime(int afapIndex, Duration duration) {
    if (afapIndex < 0 || afapIndex >= afapsCount) return;

    afaps[afapIndex] = afaps[afapIndex].copyWithNewValue(restTime: duration);

    if (afapIndex == afapsCount - 2) {
      afaps[afapIndex + 1] = afaps[afapIndex + 1].copyWithNewValue(restTime: duration);
    }
  }

  @action
  void setNoTimeCap(int afapIndex, bool noTimeCap) {
    if (afapIndex < 0 || afapIndex >= afapsCount) return;

    afaps[afapIndex] = afaps[afapIndex].copyWithNewValue(noTimeCap: noTimeCap);
  }

  @action
  void addAfap() {
    final lastAfapCopy = afaps.last.copyWithNewValue();
    afaps.add(lastAfapCopy);
  }

  @action
  void deleteAfap(int afapIndex) {
    afaps.removeAt(afapIndex);
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

    for (int i = 0; i < afapsCount; i++) {
      final afap = afaps[i];
      final setIndex = IntervalIndex(index: i, localeKey: LocaleKeys.afap_name, totalCount: afapsCount);

      final isLast = afapsCount > 1 && i == afapsCount - 1;
      final workInterval = afap.noTimeCap
          ? InfiniteInterval(
              activityType: ActivityType.work,
              isLast: isLast,
              indexes: afapsCount > 1 ? [setIndex] : [],
            )
          : FiniteInterval(
              duration: afap.timeCap,
              isReverse: false,
              canBeCompleteEarlier: true,
              activityType: ActivityType.work,
              isLast: isLast,
              indexes: afapsCount > 1 ? [setIndex] : [],
            );
      final restInterval = FiniteInterval(
        duration: afap.restTime,
        isReverse: true,
        activityType: ActivityType.rest,
        indexes: afapsCount > 1 ? [setIndex] : [],
      );
      intervals.addAll([
        workInterval,
        if (i != afapsCount - 1) restInterval,
      ]);
    }
    return Workout(intervals: intervals);
  }

  @computed
  WorkoutSettings get settings => WorkoutSettings(afap: AfapSettings(afaps: afaps));
}
