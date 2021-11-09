import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';

part 'amrap.g.dart';

class Amrap extends AmrapBase with _$Amrap {}

abstract class AmrapBase with Store {
  @observable
  ObservableList<WorkoutSet> rounds = ObservableList.of(
    [
      WorkoutSet(
        [
          Interval(
            duration: const Duration(minutes: 10),
            type: IntervalType.work,
          ),
          Interval(
            duration: const Duration(minutes: 1),
            type: IntervalType.rest,
          ),
        ],
      ),
    ],
  );

  @computed
  int get roundsCound => rounds.length;

  @action
  void addRound() {
    final lastRoundCopy = rounds.last.copy();
    rounds.add(lastRoundCopy);
  }

  @action
  void deleteRound(int roundIndex) {
    rounds.removeAt(roundIndex);
  }

  @action
  void setInterval(int roundIndex, int intervalIndex, Duration duration) {
    if (roundIndex >= rounds.length || intervalIndex >= rounds[roundIndex].sets.length) return;

    final interval = Interval(
      duration: duration,
      type: intervalIndex == 0 ? IntervalType.work : IntervalType.rest,
      isCountdown: true,
    );

    rounds[roundIndex].sets[intervalIndex] = interval;
  }

  @computed
  WorkoutSet get workout {
    final lastRoundSets = rounds.last.sets;
    final lastRound = WorkoutSet([lastRoundSets[0].copy()]);

    final roundsCopy = List.of(rounds);

    roundsCopy.removeLast();
    roundsCopy.add(lastRound);

    return WorkoutSet(roundsCopy);
  }
}
