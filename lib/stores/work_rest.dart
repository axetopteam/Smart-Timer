import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';

part 'work_rest.g.dart';

class WorkRest = WorkRestBase with _$WorkRest;

abstract class WorkRestBase with Store {
  @observable
  int roundsCount = 1;

  @observable
  int ratio = 1;

  @computed
  WorkoutSet get workout {
    Interval work = Interval(
      duration: null,
      type: IntervalType.work,
      isCountdown: false,
    );

    Interval rest = Interval(
      duration: null,
      type: IntervalType.rest,
      isCountdown: true,
      isReverse: true,
      reverseRatio: ratio,
    );

    final round = WorkoutSet([work, rest]);

    final List<WorkoutSet> sets = List.generate(roundsCount, (index) => round);

    // return round.copy();
    return WorkoutSet(sets).copy();
  }

  @action
  void setRounds(int value) {
    roundsCount = value;
  }

  @action
  void setRatio(int value) {
    ratio = value;
  }
}
