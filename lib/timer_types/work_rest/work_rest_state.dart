import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/sdk/models/workout_interval.dart';
import 'package:smart_timer/sdk/models/workout_interval_type.dart';
import 'package:smart_timer/sdk/models/workout_set.dart';

part 'work_rest_state.g.dart';

@JsonSerializable()
class WorkRestState extends WorkRestStateBase with _$WorkRestState {
  WorkRestState({
    int roundsCount = 10,
    double ratio = 1,
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
  double ratio;

  WorkoutSet get workout {
    WorkoutInterval work = WorkoutInterval(
      duration: null,
      type: WorkoutIntervalType.work,
      isCountdown: false,
    );

    WorkoutInterval rest = WorkoutInterval(
      duration: null,
      type: WorkoutIntervalType.rest,
      isCountdown: true,
      isReverse: true,
      reverseRatio: ratio,
    );

    final round = WorkoutSet([work, rest]);

    final lastRound = WorkoutSet(
      [
        WorkoutInterval(
          type: WorkoutIntervalType.work,
          duration: null,
          isCountdown: false,
          isLast: roundsCount != 1,
        ),
      ],
    );

    final List<WorkoutSet> sets =
        List.generate(roundsCount, (index) => index != roundsCount - 1 ? round.copy() : lastRound);

    return WorkoutSet(sets, descriptionSolver: _setDescriptionSolver);
  }

  String _setDescriptionSolver(int currentIndex) => 'ROUND $currentIndex/$roundsCount';

  @action
  void setRounds(int value) {
    roundsCount = value;
  }

  @action
  void setRatio(double value) {
    ratio = value;
  }
}
