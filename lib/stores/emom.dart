import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';

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

  @observable
  var showSets = false;

  @observable
  var setsCount = 1;

  @observable
  var restBetweenSets = Interval(
    duration: const Duration(minutes: 1),
    type: IntervalType.rest,
  );

  Duration get totalTime => workTime.duration! * roundsCount;

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

  WorkoutSet get workout {
    if (setsCount == 1 || !showSets) {
      List<Interval> intervals = List.generate(roundsCount, (index) => workTime);
      return WorkoutSet(intervals).copy();
    } else {
      List<Interval> intervals = List.generate(roundsCount, (index) => workTime);
      final round = WorkoutSet(intervals);

      final betweenSetsRound = WorkoutSet([restBetweenSets]);

      final set = WorkoutSet([round, betweenSetsRound]);
      final lastSet = WorkoutSet([round]);

      List<WorkoutSet> sets = List.generate(setsCount - 1, (index) => set)..add(lastSet);

      return WorkoutSet(sets).copy();
    }
  }
}
