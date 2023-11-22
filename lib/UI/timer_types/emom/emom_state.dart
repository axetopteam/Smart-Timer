import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/sdk/models/protos/emom/emom_extension.dart';
import 'package:smart_timer/sdk/models/protos/emom_settings/emom_settings.pb.dart';
import 'package:smart_timer/sdk/sdk_service.dart';

import '../timer_settings_interface.dart';

export 'package:smart_timer/sdk/models/protos/emom/emom_extension.dart';
export 'package:smart_timer/sdk/models/protos/emom_settings/emom_settings.pb.dart';

part 'emom_state.g.dart';

class EmomState = EmomStateBase with _$EmomState implements TimerSettingsInterface;

abstract class EmomStateBase with Store {
  EmomStateBase({List<Emom>? emoms}) : emoms = ObservableList.of(emoms ?? [EmomX.defaultValue]);

  final type = TimerType.emom;

  final ObservableList<Emom> emoms;

  @computed
  int get emomsCount => emoms.length;

  @action
  void setRounds(int emomIndex, int value) {
    final emom = emoms[emomIndex];
    emoms[emomIndex] = emom.copyWithNewValue(roundsCount: value);
  }

  @action
  void setWorkTime(int emomIndex, Duration duration) {
    final emom = emoms[emomIndex];
    emoms[emomIndex] = emom.copyWithNewValue(workTime: duration);
  }

  @action
  void setRestAfterSet(int emomIndex, Duration duration) {
    final emom = emoms[emomIndex];
    emoms[emomIndex] = emom.copyWithNewValue(restAfterSet: duration);
    if (emomIndex == emomsCount - 2) {
      emoms[emomIndex + 1] = emoms[emomIndex + 1].copyWithNewValue(restAfterSet: duration);
    }
  }

  @action
  void setDeathBy(int emomIndex, bool value) {
    final emom = emoms[emomIndex];
    emoms[emomIndex] = emom.copyWithNewValue(deathBy: value);
  }

  @action
  void addEmom() {
    final newEmom = emoms.last.copyWithNewValue();
    emoms.add(newEmom);
  }

  @action
  void deleteEmom(int emomIndex) {
    emoms.removeAt(emomIndex);
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

    for (var i = 0; i < emomsCount; i++) {
      final emom = emoms[i];
      List<Interval> setIntervals;
      if (emom.deathBy) {
        setIntervals = [
          FiniteInterval(
            duration: emom.workTime,
            isReverse: true,
            activityType: ActivityType.work,
            indexes: [
              if (emomsCount > 1) IntervalIndex(localeKey: LocaleKeys.emom_title, index: i, totalCount: emomsCount),
              IntervalIndex(localeKey: LocaleKeys.round, index: 0),
            ],
          ),
          RepeatLastInterval(
            activityType: ActivityType.work,
            indexes: [
              if (emomsCount > 1) IntervalIndex(localeKey: LocaleKeys.emom_title, index: i, totalCount: emomsCount),
              IntervalIndex(localeKey: LocaleKeys.round, index: 1),
            ],
          ),
          if (i != emomsCount - 1)
            FiniteInterval(
              duration: emom.restAfterSet,
              isReverse: true,
              activityType: ActivityType.rest,
              indexes: [
                if (emomsCount > 1) IntervalIndex(localeKey: LocaleKeys.emom_title, index: i, totalCount: emomsCount),
              ],
            ),
        ];
      } else {
        setIntervals = List.generate(
          emom.roundsCount,
          (index) => FiniteInterval(
            duration: emom.workTime,
            isReverse: true,
            activityType: ActivityType.work,
            indexes: [
              if (emomsCount > 1) IntervalIndex(localeKey: LocaleKeys.emom_title, index: i, totalCount: emomsCount),
              IntervalIndex(localeKey: LocaleKeys.round, index: index, totalCount: emom.roundsCount),
            ],
            isLast: emom.roundsCount != 1 && index == emom.roundsCount - 1,
          ),
        );
        if (i != emomsCount - 1) {
          setIntervals.add(
            FiniteInterval(
              duration: emom.restAfterSet,
              isReverse: true,
              activityType: ActivityType.rest,
              indexes: [
                if (emomsCount > 1) IntervalIndex(localeKey: LocaleKeys.emom_title, index: i, totalCount: emomsCount),
              ],
            ),
          );
        }
      }
      intervals.addAll(setIntervals);
    }
    return Workout(intervals: intervals);
  }

  @computed
  WorkoutSettings get settings => WorkoutSettings(emom: EmomSettings(emoms: emoms));
}
