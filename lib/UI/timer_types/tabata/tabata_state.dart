import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/sdk/models/protos/tabata/tabata_extension.dart';
import 'package:smart_timer/sdk/models/protos/tabata_settings/tabata_settings.pb.dart';
import 'package:smart_timer/sdk/sdk_service.dart';

import '../timer_settings_interface.dart';

export 'package:smart_timer/sdk/models/protos/tabata/tabata_extension.dart';
export 'package:smart_timer/sdk/models/protos/tabata_settings/tabata_settings.pb.dart';

part 'tabata_state.g.dart';

class TabataState = TabataStoreBase with _$TabataState implements TimerSettingsInterface;

abstract class TabataStoreBase with Store {
  TabataStoreBase({List<Tabata>? tabats}) : tabats = ObservableList.of(tabats ?? [TabataX.defaultValue]);

  final ObservableList<Tabata> tabats;

  final type = TimerType.tabata;

  @computed
  int get tabatsCount => tabats.length;

  @action
  void setRounds(int tabataIndex, int value) {
    final tabata = tabats[tabataIndex];

    tabats[tabataIndex] = tabata.copyWithNewValue(roundsCount: value);
  }

  @action
  void setWorkTime(int tabataIndex, Duration duration) {
    tabats[tabataIndex] = tabats[tabataIndex].copyWithNewValue(workTime: duration);
  }

  @action
  void setRestTime(int tabataIndex, Duration duration) {
    tabats[tabataIndex] = tabats[tabataIndex].copyWithNewValue(restTime: duration);
  }

  @action
  void setRestAfterSet(int tabataIndex, Duration duration) {
    tabats[tabataIndex] = tabats[tabataIndex].copyWithNewValue(restAfterSet: duration);

    if (tabataIndex == tabatsCount - 2) {
      tabats[tabataIndex + 1] = tabats[tabataIndex + 1].copyWithNewValue(restAfterSet: duration);
    }
  }

  @action
  void addTabata() {
    final newEmom = tabats.last.copyWithNewValue();
    tabats.add(newEmom);
  }

  @action
  void deleteTabata(int tabataIndex) {
    tabats.removeAt(tabataIndex);
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
    final intervals = <Interval>[];
    for (var i = 0; i < tabatsCount; i++) {
      final tabata = tabats[i];

      final workInterval =
          FiniteInterval(duration: tabata.workTime, isReverse: true, activityType: ActivityType.work, indexes: []);
      final restInterval =
          FiniteInterval(duration: tabata.restTime, isReverse: true, activityType: ActivityType.rest, indexes: []);
      final restAfterSet =
          FiniteInterval(duration: tabata.restAfterSet, isReverse: true, activityType: ActivityType.rest, indexes: []);
      final setIndex = IntervalIndex(index: i + 1, localeKey: 'TABATA', totalCount: tabatsCount);
      final roundIndex = IntervalIndex(index: 0, localeKey: 'ROUND', totalCount: tabata.roundsCount);

      final roundIntervals = <Interval>[];
      for (var j = 0; j < tabata.roundsCount; j++) {
        roundIntervals.addAll(
          [
            workInterval.copyWith(
                isLast: tabata.roundsCount != 1 && j == tabata.roundsCount - 1,
                indexes: [if (tabatsCount > 1) setIndex, roundIndex.copyWith(j + 1)]),
            if (j != tabata.roundsCount - 1)
              restInterval.copyWith(indexes: [if (tabatsCount > 1) setIndex, roundIndex.copyWith(j + 1)]),
            if (j == tabata.roundsCount - 1 && i != tabatsCount - 1)
              restAfterSet.copyWith(indexes: [if (tabatsCount > 1) setIndex]),
          ],
        );
      }
      intervals.addAll(roundIntervals);
    }
    return Workout(
      intervals: intervals,
    );
  }

  @computed
  WorkoutSettings get settings => WorkoutSettings(tabata: TabataSettings(tabats: tabats));
}
