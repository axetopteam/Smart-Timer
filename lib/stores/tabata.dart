import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/round.dart';
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
  Duration get totalTime => workTime.duration * roundsCount + restTime.duration * (roundsCount - 1);

  @computed
  Round get workout {
    if (setsCount == 1) {
      Round baseRound = Round([workTime, restTime]);
      Round lastRound = Round([workTime.copy()]);

      List<Round> rounds = List.generate(roundsCount - 1, (index) => baseRound);
      rounds.add(lastRound);

      return Round(rounds);
    } else {
      Round baseRound = Round([workTime, restTime]);
      Round lastRoundInSet = Round([workTime, restBetweenSets]);
      Round lastRound = Round([workTime]);

      List<Round> baseRounds = List.generate(roundsCount - 1, (index) => baseRound)..add(lastRoundInSet);

      List<Round> lastRounds = List.generate(roundsCount - 1, (index) => baseRound)..add(lastRound);

      final sets = List.generate(setsCount - 1, (index) => Round(baseRounds));
      sets.add(Round(lastRounds));
      return Round(sets).copy();
    }
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
