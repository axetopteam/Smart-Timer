import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/round.dart';
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

  @computed
  Duration get totalTime => (workTime.duration! + restTime.duration!) * roundsCount;

  @computed
  Workout get workout {
    final round = Round([workTime, restTime]);
    List<Round> rounds = [];

    for (int i = 0; i < roundsCount; i++) {
      rounds.add(round);
    }
    return Workout.withLauchRound(rounds);
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
}
