import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';

part 'tabata_state.g.dart';

class TabataState = TabataStoreBase with _$TabataState;

abstract class TabataStoreBase with Store {
  TabataStoreBase({
    required this.roundsCount,
    required Duration workDuration,
    required Duration restDuration,
    required this.showSets,
    required this.setsCount,
    required Duration restBetweenSetsDuration,
  })  : workTime = Interval(
          duration: workDuration,
          type: IntervalType.work,
        ),
        restTime = Interval(
          duration: restDuration,
          type: IntervalType.rest,
        ),
        restBetweenSets = Interval(
          duration: restBetweenSetsDuration,
          type: IntervalType.rest,
        );

  @observable
  int roundsCount;

  @observable
  Interval workTime;

  @observable
  Interval restTime;

  @observable
  bool showSets;

  @observable
  int setsCount;

  @observable
  Interval restBetweenSets;

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
    WorkoutSet lastRound = WorkoutSet([workTime.copyWith(isLast: true)]);

    if (setsCount == 1 || !showSets) {
      WorkoutSet baseRound = WorkoutSet([workTime, restTime]);
      List<WorkoutSet> rounds = List.generate(roundsCount - 1, (index) => baseRound);
      rounds.add(lastRound);

      return WorkoutSet(rounds).copy();
    } else {
      WorkoutSet baseRound = WorkoutSet([workTime, restTime]);
      WorkoutSet lastRoundInSet = WorkoutSet([workTime, restBetweenSets]);

      List<WorkoutSet> baseRounds = List.generate(roundsCount - 1, (index) => baseRound)..add(lastRoundInSet);

      List<WorkoutSet> lastRounds = List.generate(roundsCount - 1, (index) => baseRound)..add(lastRound);

      final sets = List.generate(setsCount - 1, (index) => WorkoutSet(baseRounds));
      sets.add(WorkoutSet(lastRounds));
      return WorkoutSet(sets).copy();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'roundsCount': roundsCount,
      'workSeconds': workTime.duration?.inSeconds,
      'restSeconds': restTime.duration?.inSeconds,
      'showSets': showSets,
      'setsCount': setsCount,
      'restBetweenSetsSeconds': restBetweenSets.duration?.inSeconds,
    };
  }

  TabataStoreBase.fromJson(Map<String, dynamic>? json)
      : roundsCount = json?['roundsCount'] ?? 8,
        workTime = Interval(
          type: IntervalType.work,
          duration: Duration(seconds: json?['workSeconds'] ?? 20),
        ),
        restTime = Interval(
          type: IntervalType.rest,
          duration: Duration(seconds: json?['restSeconds'] ?? 10),
        ),
        showSets = json?['showSets'] ?? false,
        setsCount = json?['setsCount'] ?? 1,
        restBetweenSets = Interval(
          type: IntervalType.rest,
          duration: Duration(seconds: json?['restBetweenSetsSeconds'] ?? 60),
        );
}
