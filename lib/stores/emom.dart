import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/round.dart';
import 'package:smart_timer/models/workout.dart';

part 'emom.g.dart';

class Emom = EmomBase with _$Emom;

abstract class EmomBase with Store {
  @observable
  var roundsCount = 10;

  @observable
  var workTime = Interval(
    duration: const Duration(minutes: 1),
    type: IntervalType.work,
  );

  Duration get totalTime => workTime.duration! * roundsCount;

  @computed
  Workout get workout {
    final round = Round([workTime]);
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
}
