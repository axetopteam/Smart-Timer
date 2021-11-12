import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';

part 'emom.g.dart';

@JsonSerializable()
class Emom extends EmomBase with _$Emom {
  Emom({
    int? roundsCount,
    Duration? workTime,
    bool? showSets,
    int? setsCount,
    Duration? restBetweenSets,
  }) : super(
          roundsCount: roundsCount,
          workTime: workTime,
          showSets: showSets,
          setsCount: setsCount,
          restBetweenSets: restBetweenSets,
        );
  Map<String, dynamic> toJson() => _$EmomToJson(this);

  factory Emom.fromJson(Map<String, dynamic> json) => _$EmomFromJson(json);
}

abstract class EmomBase with Store {
  EmomBase({
    int? roundsCount,
    Duration? workTime,
    bool? showSets,
    int? setsCount,
    Duration? restBetweenSets,
  })  : roundsCount = roundsCount ?? 10,
        workTime = workTime ?? const Duration(minutes: 1),
        showSets = showSets ?? false,
        setsCount = setsCount ?? 1,
        restBetweenSets = restBetweenSets ?? const Duration(minutes: 1);

  @observable
  int roundsCount;

  @observable
  Duration workTime;

  @observable
  bool showSets;

  @observable
  int setsCount;

  @observable
  Duration restBetweenSets;

  // Duration get totalTime => workTime.duration! * roundsCount;

  @action
  void setRounds(int value) {
    roundsCount = value;
  }

  @action
  void setWorkTime(Duration duration) {
    workTime = duration;
  }

  @action
  void toggleShowSets() {
    showSets = !showSets;
  }

  @action
  void setRestBetweenSets(Duration duration) {
    restBetweenSets = duration;
  }

  @action
  void setSetsCount(int value) {
    setsCount = value;
  }

  WorkoutSet get workout {
    final setsCount = showSets ? this.setsCount : 1;

    List<Interval> intervals = List.generate(
      roundsCount,
      (index) => Interval(
        duration: workTime,
        type: IntervalType.work,
      ),
    );
    final round = WorkoutSet(intervals);

    final betweenSetsRound = WorkoutSet([
      Interval(
        duration: restBetweenSets,
        type: IntervalType.rest,
      )
    ]);

    final set = WorkoutSet([round, betweenSetsRound]);

    List<Interval> lastIntervals = List.generate(
      roundsCount,
      (index) => Interval(
        duration: workTime,
        type: IntervalType.work,
        isLast: index == roundsCount - 1,
      ),
    );
    final lastRound = WorkoutSet(lastIntervals);

    final lastSet = WorkoutSet([lastRound]);

    List<WorkoutSet> sets = List.generate(setsCount - 1, (index) => set)..add(lastSet);

    return WorkoutSet(sets).copy();
  }
}
