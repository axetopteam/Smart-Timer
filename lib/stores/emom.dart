import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';

part 'emom.g.dart';

@JsonSerializable()
class Emom extends EmomBase with _$Emom {
  Emom({
    int roundsCount = 10,
    Duration workTime = const Duration(minutes: 1),
    bool showSets = false,
    int setsCount = 1,
    Duration restBetweenSets = const Duration(minutes: 1),
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
    required this.roundsCount,
    required this.workTime,
    required this.showSets,
    required this.setsCount,
    required this.restBetweenSets,
  });

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
    if (setsCount == 1 || !showSets) {
      List<Interval> intervals = List.generate(
          roundsCount,
          (index) => Interval(
                duration: workTime,
                type: IntervalType.work,
              ));
      return WorkoutSet(intervals).copy();
    } else {
      List<Interval> intervals = List.generate(
          roundsCount,
          (index) => Interval(
                duration: workTime,
                type: IntervalType.work,
              ));
      final round = WorkoutSet(intervals);

      final betweenSetsRound = WorkoutSet([
        Interval(
          duration: restBetweenSets,
          type: IntervalType.work,
        )
      ]);

      final set = WorkoutSet([round, betweenSetsRound]);
      final lastSet = WorkoutSet([round]);

      List<WorkoutSet> sets = List.generate(setsCount - 1, (index) => set)..add(lastSet);

      return WorkoutSet(sets).copy();
    }
  }

  // Map<String, dynamic> toJson() => _$EmomBase(this);
}
