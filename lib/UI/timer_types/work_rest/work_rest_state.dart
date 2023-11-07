import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/sdk/models/protos/work_rest/work_rest_extension.dart';
import 'package:smart_timer/sdk/models/protos/work_rest_settings/work_rest_settings.pb.dart';
import 'package:smart_timer/sdk/models/workout_interval.dart';
import 'package:smart_timer/sdk/models/workout_interval_type.dart';
import 'package:smart_timer/sdk/sdk_service.dart';

import '../timer_settings_interface.dart';

export 'package:smart_timer/sdk/models/protos/work_rest/work_rest_extension.dart';
export 'package:smart_timer/sdk/models/protos/work_rest_settings/work_rest_settings.pb.dart';

part 'work_rest_state.g.dart';

class WorkRestState = WorkRestStateBase with _$WorkRestState implements TimerSettingsInterface;

abstract class WorkRestStateBase with Store {
  WorkRestStateBase({List<WorkRest>? sets}) : sets = ObservableList.of(sets ?? [WorkRestX.defaultValue]);
  final setIndex = 0;

  final ObservableList<WorkRest> sets;

  final type = TimerType.workRest;

  @action
  void setRounds(int setIndex, int value) {
    final set = sets[setIndex];

    sets[setIndex] = set.copyWithNewValue(roundsCount: value);
  }

  @action
  void setRatio(int setIndex, double value) {
    final set = sets[setIndex];

    sets[setIndex] = set.copyWithNewValue(ratio: value);
  }

  Future<void> saveToFavorites({required String name, required String description}) async {
    return GetIt.I<SdkService>().addToFavorite(
      settings: settings,
      name: name,
      description: description,
    );
  }

  Workout get workout {
    return Workout(intervals: [], description: _setDescriptionSolver);
    WorkoutInterval work = WorkoutInterval(
      duration: null,
      type: IntervalType.work,
      isCountdown: false,
    );

    WorkoutInterval rest = WorkoutInterval(
      duration: null,
      type: IntervalType.rest,
      isCountdown: true,
      isReverse: true,
      reverseRatio: sets[setIndex].ratio,
    );

    final round = WorkoutSet([work, rest]);

    final lastRound = WorkoutSet(
      [
        WorkoutInterval(
          type: IntervalType.work,
          duration: null,
          isCountdown: false,
          isLast: sets[setIndex].roundsCount != 1,
        ),
      ],
    );

    final List<WorkoutSet> rounds = List.generate(
        sets[setIndex].roundsCount, (index) => index != sets[setIndex].roundsCount - 1 ? round.copy() : lastRound);

    // return WorkoutSet(rounds, descriptionSolver: _setDescriptionSolver);
  }

  @computed
  WorkoutSettings get settings => WorkoutSettings(workRest: WorkRestSettings(workRests: sets));

  String _setDescriptionSolver(int currentIndex) => 'ROUND $currentIndex/${sets[setIndex].roundsCount}';
}
