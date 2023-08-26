import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/workout_interval.dart';
import 'package:smart_timer/models/workout_interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';

import 'amrap.dart';
export 'amrap.dart';

part 'amrap_state.g.dart';

@JsonSerializable()
class AmrapState extends AmrapStateBase with _$AmrapState {
  AmrapState({List<Amrap>? amraps}) : super(amraps: amraps);

  Map<String, dynamic> toJson() => _$AmrapStateToJson(this);

  factory AmrapState.fromJson(Map<String, dynamic> json) => _$AmrapStateFromJson(json);
}

abstract class AmrapStateBase with Store {
  AmrapStateBase({List<Amrap>? amraps}) : amraps = ObservableList.of(amraps ?? [Amrap.defaultValue]);

  ObservableList<Amrap> amraps;

  @computed
  int get amrapsCount => amraps.length;

  @action
  void setWorkTime(int amrapIndex, Duration duration) {
    if (amrapIndex < 0 || amrapIndex >= amrapsCount) return;

    amraps[amrapIndex] = amraps[amrapIndex].copyWith(workTime: duration);
  }

  @action
  void setRestTime(int amrapIndex, Duration duration) {
    if (amrapIndex < 0 || amrapIndex >= amrapsCount) return;

    amraps[amrapIndex] = amraps[amrapIndex].copyWith(restTime: duration);
    if (amrapIndex == amrapsCount - 2) {
      amraps[amrapIndex + 1] = amraps[amrapIndex + 1].copyWith(restTime: duration);
    }
  }

  @action
  void addAmrap() {
    final lastAmrapCopy = amraps.last.copyWith();
    amraps.add(lastAmrapCopy);
  }

  @action
  void deleteAmrap(int amrapIndex) {
    amraps.removeAt(amrapIndex);
  }

  WorkoutSet get workout {
    final List<WorkoutSet> sets = [];
    for (int i = 0; i < amrapsCount; i++) {
      final amrap = WorkoutSet(
        [
          WorkoutInterval(
            type: WorkoutIntervalType.work,
            duration: amraps[i].workTime,
            isLast: amrapsCount != 1 && i == amrapsCount - 1,
          ),
          if (i != amrapsCount - 1) WorkoutInterval(type: WorkoutIntervalType.rest, duration: amraps[i].restTime),
        ],
      );
      sets.add(amrap);
    }

    return WorkoutSet(sets, descriptionSolver: _descriptionSolver);
  }

  String _descriptionSolver(int currentAmrapIndex) {
    return 'AMRAP $currentAmrapIndex/$amrapsCount';
  }
}
