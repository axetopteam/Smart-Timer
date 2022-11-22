import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';

part 'work_rest_state.g.dart';

@JsonSerializable()
class WorkRestState extends WorkRestStateBase with _$WorkRestState {
  WorkRestState({
    int roundsCount = 10,
    int ratio = 1,
  }) : super(roundsCount: roundsCount, ratio: ratio);

  Map<String, dynamic> toJson() => _$WorkRestStateToJson(this);

  factory WorkRestState.fromJson(Map<String, dynamic> json) => _$WorkRestStateFromJson(json);
}

abstract class WorkRestStateBase with Store {
  WorkRestStateBase({
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

    final lastRound = WorkoutSet(
      [
        Interval(type: IntervalType.work, duration: null, isCountdown: false, isLast: true),
      ],
    );

    final List<WorkoutSet> sets = List.generate(roundsCount, (index) => index != roundsCount - 1 ? round : lastRound);

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
