import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';

import 'emom.dart';

part 'emom_state.g.dart';

@JsonSerializable()
class EmomState extends EmomStateBase with _$EmomState {
  EmomState({
    super.emoms,
    Duration? workTime,
  });
  Map<String, dynamic> toJson() => _$EmomStateToJson(this);

  factory EmomState.fromJson(Map<String, dynamic> json) => _$EmomStateFromJson(json);
}

abstract class EmomStateBase with Store {
  static final initialEmom = Emom(
    workTime: const Duration(minutes: 1),
    roundsCount: 10,
    restAfterSet: const Duration(minutes: 2),
  );

  EmomStateBase({List<Emom>? emoms}) : emoms = ObservableList.of(emoms ?? [initialEmom]);

  final ObservableList<Emom> emoms;

  // Duration get totalTime => workTime.duration! * roundsCount;

  @action
  void setRounds(int emomIndex, int value) {
    final emom = emoms[emomIndex];
    emoms[emomIndex] = emom.copyWith(rounds: value);
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
  }

  void addEmom() {
    final newEmom = emoms.last.copyWith();
    emoms.add(newEmom);
  }

  void deleteEmom(int emomIndex) {
    emoms.removeAt(emomIndex);
  }

  WorkoutSet get workout {
    List<WorkoutSet> sets = [];
    for (var i = 0; i < emoms.length; i++) {
      final emom = emoms[i];
      List<Interval> intervals = List.generate(
        emom.roundsCount,
        (index) => Interval(
          duration: emom.workTime,
          type: IntervalType.work,
        ),
      );
      if (i != emoms.length - 1) {
        intervals.add(Interval(
          duration: emom.restAfterSet,
          type: IntervalType.rest,
        ));
      }
      final set = WorkoutSet(intervals);

      sets.add(set);
    }

    return WorkoutSet(sets).copy();
  }
}
