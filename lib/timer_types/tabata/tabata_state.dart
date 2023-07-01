import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';

import 'tabata.dart';

part 'tabata_state.g.dart';

@JsonSerializable()
class TabataState extends TabataStoreBase with _$TabataState {
  TabataState({super.tabats});

  Map<String, dynamic> toJson() => _$TabataStateToJson(this);

  factory TabataState.fromJson(Map<String, dynamic> json) => _$TabataStateFromJson(json);
}

abstract class TabataStoreBase with Store {
  TabataStoreBase({List<Tabata>? tabats}) : tabats = ObservableList.of(tabats ?? [Tabata.defaultValue]);

  final ObservableList<Tabata> tabats;

  @computed
  int get tabatsCount => tabats.length;

  // @computed
  // Duration get totalTime => workTime * roundsCount + restTime * (roundsCount - 1);
  @action
  void setRounds(int tabataIndex, int value) {
    final tabata = tabats[tabataIndex];

    tabats[tabataIndex] = tabata.copyWith(roundsCount: value);
  }

  @action
  void setWorkTime(int tabataIndex, Duration duration) {
    tabats[tabataIndex] = tabats[tabataIndex].copyWith(workTime: duration);
  }

  @action
  void setRestTime(int tabataIndex, Duration duration) {
    tabats[tabataIndex] = tabats[tabataIndex].copyWith(restTime: duration);
  }

  @action
  void setRestAfterSet(int tabataIndex, Duration duration) {
    tabats[tabataIndex] = tabats[tabataIndex].copyWith(restAfterSet: duration);
  }

  @action
  void addTabata() {
    final newEmom = tabats.last.copyWith();
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

      final workInterval = Interval(duration: tabata.workTime, type: IntervalType.work);
      final restInterval = Interval(duration: tabata.restTime, type: IntervalType.rest);
      final restAfterSet = Interval(duration: tabata.restAfterSet, type: IntervalType.rest);

      final rounds = <WorkoutSet>[];
      for (var j = 0; j < tabata.roundsCount; j++) {
        final round = WorkoutSet([
          workInterval.copyWith(isLast: j == tabata.roundsCount - 1),
          if (j != tabata.roundsCount - 1) restInterval.copy(),
          if (j == tabata.roundsCount - 1 && i != tabatsCount - 1) restAfterSet.copy(),
        ]);
        rounds.add(round);
      }
      sets.add(WorkoutSet(rounds));
    }

    return WorkoutSet(sets);
  }
}
