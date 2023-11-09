import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/sdk/models/protos/tabata/tabata_extension.dart';
import 'package:smart_timer/sdk/models/protos/tabata_settings/tabata_settings.pb.dart';
import 'package:smart_timer/sdk/models/workout_interval_type.dart';
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

      final workInterval = FiniteInterval(duration: tabata.workTime, type: IntervalType.work);
      final restInterval = FiniteInterval(duration: tabata.restTime, type: IntervalType.rest);
      final restAfterSet = FiniteInterval(duration: tabata.restAfterSet, type: IntervalType.rest);

      final roundIntervals = <Interval>[];
      for (var j = 0; j < tabata.roundsCount; j++) {
        roundIntervals.addAll(
          [
            workInterval.copyWith(isLast: tabata.roundsCount != 1 && j == tabata.roundsCount - 1),
            if (j != tabata.roundsCount - 1) restInterval,
            if (j == tabata.roundsCount - 1 && i != tabatsCount - 1) restAfterSet,
          ],
        );
      }
      intervals.addAll(roundIntervals);
    }
    return Workout(intervals: intervals, description: _descriptionSolver);
  }

  String _descriptionSolver(int currentIndex) {
    var index = currentIndex;

    for (var tabataIndex = 0; tabataIndex < tabatsCount; tabataIndex++) {
      final tabataRoundsCount = tabats[tabataIndex].roundsCount;

      if (index < 2 * tabataRoundsCount) {
        final buffer = StringBuffer();
        if (tabatsCount > 1) {
          buffer.write('SET ${tabataIndex + 1}/$tabatsCount');
          buffer.write('\n');
        }
        buffer.write('Round ${(index ~/ 2) + 1}/$tabataRoundsCount');

        return buffer.toString();
      }
      index -= (2 * tabataRoundsCount);
    }

    return '';
  }

  @computed
  WorkoutSettings get settings => WorkoutSettings(tabata: TabataSettings(tabats: tabats));
}
