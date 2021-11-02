import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';
// import 'package:smart_timer/models/set.dart';
// import 'package:smart_timer/models/workout.dart';

part 'tabata.g.dart';

class TabataStore = TabataStoreBase with _$TabataStore;

abstract class TabataStoreBase with Store {
  @observable
  var roundsCount = 8;

  @observable
  var workTime = Interval(
    duration: const Duration(seconds: 10),
    type: IntervalType.work,
  );

  @observable
  var restTime = Interval(
    duration: const Duration(seconds: 5),
    type: IntervalType.rest,
  );

  @observable
  var showSets = false;

  @observable
  var setsCount = 1;

  @observable
  var restBetweenSets = Interval(
    duration: const Duration(minutes: 1),
    type: IntervalType.rest,
  );

  @computed
  Duration get totalTime => workTime.duration! * roundsCount + restTime.duration! * (roundsCount - 1);

  @action
  void setRounds(int value) {
    roundsCount = value;
  }

  @action
  void setWorkTime(Duration duration) {
    workTime = Interval(
      duration: duration,
      type: IntervalType.work,
    );
  }

  @action
  void setRestTime(Duration duration) {
    restTime = Interval(
      duration: duration,
      type: IntervalType.rest,
    );
  }

  @action
  void toggleShowSets() {
    showSets = !showSets;
  }

  @action
  void setRestBetweenSets(Duration duration) {
    restBetweenSets = Interval(
      duration: duration,
      type: IntervalType.rest,
    );
  }

  @action
  void setSetsCount(int value) {
    setsCount = value;
  }

  @computed
  WorkoutSet get workout {
    if (setsCount == 1 || !showSets) {
      WorkoutSet baseRound = WorkoutSet([workTime, restTime]);
      WorkoutSet lastRound = WorkoutSet([workTime.copy()]);

      List<WorkoutSet> rounds = List.generate(roundsCount - 1, (index) => baseRound);
      rounds.add(lastRound);

      return WorkoutSet(rounds).copy();
    } else {
      WorkoutSet baseRound = WorkoutSet([workTime, restTime]);
      WorkoutSet lastRoundInSet = WorkoutSet([workTime, restBetweenSets]);
      WorkoutSet lastRound = WorkoutSet([workTime]);

      List<WorkoutSet> baseRounds = List.generate(roundsCount - 1, (index) => baseRound)..add(lastRoundInSet);

      List<WorkoutSet> lastRounds = List.generate(roundsCount - 1, (index) => baseRound)..add(lastRound);

      final sets = List.generate(setsCount - 1, (index) => WorkoutSet(baseRounds));
      sets.add(WorkoutSet(lastRounds));
      return WorkoutSet(sets).copy();
    }
  }
}
