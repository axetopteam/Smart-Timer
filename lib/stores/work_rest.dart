import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';

part 'work_rest.g.dart';

@JsonSerializable()
class WorkRest extends WorkRestBase with _$WorkRest {
  WorkRest({
    int roundsCount = 10,
    int ratio = 1,
  }) : super(roundsCount: roundsCount, ratio: ratio);

  Map<String, dynamic> toJson() => _$WorkRestToJson(this);

  factory WorkRest.fromJson(Map<String, dynamic> json) => _$WorkRestFromJson(json);
}

abstract class WorkRestBase with Store {
  WorkRestBase({
    required this.roundsCount,
    required this.ratio,
  });

  @observable
  int roundsCount;

  @observable
  int ratio;

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
