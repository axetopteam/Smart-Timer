import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/workout_interval.dart';
import 'package:smart_timer/models/workout_interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';

import 'emom.dart';

part 'emom_state.g.dart';

@JsonSerializable()
class EmomState extends EmomStateBase with _$EmomState {
  EmomState({super.emoms});

  Map<String, dynamic> toJson() => _$EmomStateToJson(this);

  factory EmomState.fromJson(Map<String, dynamic> json) => _$EmomStateFromJson(json);
}

abstract class EmomStateBase with Store {
  EmomStateBase({List<Emom>? emoms}) : emoms = ObservableList.of(emoms ?? [Emom.defaultValue]);

  final ObservableList<Emom> emoms;

  @computed
  int get emomsCount => emoms.length;

  // Duration get totalTime => workTime.duration! * roundsCount;

  @action
  void setRounds(int emomIndex, int value) {
    final emom = emoms[emomIndex];
    emoms[emomIndex] = emom.copyWith(roundsCount: value);
  }

  @action
  void setWorkTime(int emomIndex, Duration duration) {
    final emom = emoms[emomIndex];
    emoms[emomIndex] = emom.copyWith(workTime: duration);
  }

  @action
  void setRestAfterSet(int emomIndex, Duration duration) {
    final emom = emoms[emomIndex];
    emoms[emomIndex] = emom.copyWith(restAfterSet: duration);
    if (emomIndex == emomsCount - 2) {
      emoms[emomIndex + 1] = emoms[emomIndex + 1].copyWith(restAfterSet: duration);
    }
  }

  @action
  void addEmom() {
    final newEmom = emoms.last.copyWith();
    emoms.add(newEmom);
  }

  @action
  void deleteEmom(int emomIndex) {
    emoms.removeAt(emomIndex);
  }

  WorkoutSet get workout {
    List<WorkoutSet> sets = [];
    for (var i = 0; i < emomsCount; i++) {
      final emom = emoms[i];
      List<WorkoutInterval> intervals = List.generate(
        emom.roundsCount,
        (index) => WorkoutInterval(
          duration: emom.workTime,
          type: WorkoutIntervalType.work,
          isLast: emom.roundsCount != 1 && index == emom.roundsCount - 1,
        ),
      );
      if (i != emomsCount - 1) {
        intervals.add(WorkoutInterval(
          duration: emom.restAfterSet,
          type: WorkoutIntervalType.rest,
        ));
      }
      String? roundDescriptionSolver(int currentIndex) =>
          (currentIndex <= emom.roundsCount) ? 'ROUND $currentIndex/${emom.roundsCount}' : null;

      final set = WorkoutSet(intervals, descriptionSolver: roundDescriptionSolver);

      sets.add(set);
    }

    return WorkoutSet(sets, descriptionSolver: _setDescriptionSolver);
  }

  String _setDescriptionSolver(int currentIndex) {
    return 'SET $currentIndex/$emomsCount';
  }
}
