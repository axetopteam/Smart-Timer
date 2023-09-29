import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/sdk/models/protos/tabata/tabata_extension.dart';
import 'package:smart_timer/sdk/models/workout_interval.dart';
import 'package:smart_timer/sdk/models/workout_interval_type.dart';
import 'package:smart_timer/sdk/models/workout_set.dart';

export 'package:smart_timer/sdk/models/protos/tabata/tabata_extension.dart';

part 'tabata_state.g.dart';

@JsonSerializable()
class TabataState extends TabataStoreBase with _$TabataState {
  TabataState({super.tabats});
}

abstract class TabataStoreBase with Store {
  TabataStoreBase({List<Tabata>? tabats}) : tabats = ObservableList.of(tabats ?? [TabataX.defaultValue]);

  final ObservableList<Tabata> tabats;

  @computed
  int get tabatsCount => tabats.length;

  // @computed
  // Duration get totalTime => workTime * roundsCount + restTime * (roundsCount - 1);
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

  WorkoutSet get workout {
    final sets = <WorkoutSet>[];
    for (var i = 0; i < tabatsCount; i++) {
      final tabata = tabats[i];

      final workInterval = WorkoutInterval(duration: tabata.workTime, type: WorkoutIntervalType.work);
      final restInterval = WorkoutInterval(duration: tabata.restTime, type: WorkoutIntervalType.rest);
      final restAfterSet = WorkoutInterval(duration: tabata.restAfterSet, type: WorkoutIntervalType.rest);

      final rounds = <WorkoutSet>[];
      for (var j = 0; j < tabata.roundsCount; j++) {
        final round = WorkoutSet([
          workInterval.copyWith(isLast: tabata.roundsCount != 1 && j == tabata.roundsCount - 1),
          if (j != tabata.roundsCount - 1) restInterval.copy(),
          if (j == tabata.roundsCount - 1 && i != tabatsCount - 1) restAfterSet.copy(),
        ]);
        rounds.add(round);
      }
      String? roundDescriptionSolver(int currentIndex) =>
          (currentIndex <= tabata.roundsCount) ? 'ROUND $currentIndex/${tabata.roundsCount}' : null;

      sets.add(WorkoutSet(rounds, descriptionSolver: roundDescriptionSolver));
    }

    String setDescriptionSolver(int currentIndex) => 'SET $currentIndex/$tabatsCount';

    return WorkoutSet(sets, descriptionSolver: setDescriptionSolver);
  }
}
