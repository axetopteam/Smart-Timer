import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/round.dart';
import 'package:smart_timer/models/set.dart';
import 'package:smart_timer/models/workout.dart';

part 'tabata.g.dart';

class TabataStore = TabataStoreBase with _$TabataStore;

abstract class TabataStoreBase with Store {
  @observable
  var roundsCount = 8;

  @observable
  var workTime = Interval(
    duration: const Duration(seconds: 20),
    type: IntervalType.work,
  );

  @observable
  var restTime = Interval(
    duration: const Duration(seconds: 10),
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

  @computed
  Workout get workout {
    final round = Round(ObservableList.of([workTime, restTime]));
    Round(ObservableList.of([workTime]));
    ObservableList<Round> baseRounds = ObservableList<Round>();

    for (int j = 0; j < roundsCount - 1; j++) {
      baseRounds.add(round);
    }
    final rounds = ObservableList<Round>.of(baseRounds)..add(Round(ObservableList.of([workTime, restBetweenSets])));
    final lastRounds = ObservableList<Round>.of(baseRounds)..add(Round(ObservableList.of([workTime])));

    List<WorkoutSet> sets = [];

    for (int i = 0; i < setsCount - 1; i++) {
      sets.add(WorkoutSet(rounds));
    }

    sets.add(WorkoutSet(lastRounds));

    return Workout.withCountdownInterval2(sets);
  }

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
}
