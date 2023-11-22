import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/sdk/models/protos/work_rest/work_rest_extension.dart';
import 'package:smart_timer/sdk/models/protos/work_rest_settings/work_rest_settings.pb.dart';
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
    final intervals = <Interval>[];
    for (var i = 0; i < sets.length; i++) {
      final set = sets[i];

      final workInterval = InfiniteInterval(activityType: ActivityType.work, indexes: []);
      final restInterval = RatioInterval(activityType: ActivityType.rest, ratio: set.ratio, indexes: []);
      final restAfterSet =
          FiniteInterval(duration: set.restAfterSet, isReverse: true, activityType: ActivityType.rest, indexes: []);

      final setIndex = IntervalIndex(index: i, localeKey: LocaleKeys.set, totalCount: sets.length);
      final roundIndex = IntervalIndex(index: 0, localeKey: LocaleKeys.round, totalCount: set.roundsCount);

      final setIntervals = <Interval>[];
      for (var j = 0; j < set.roundsCount; j++) {
        setIntervals.addAll(
          [
            workInterval.copyWith(
              isLast: set.roundsCount != 1 && j == set.roundsCount - 1,
              indexes: [if (sets.length > 1) setIndex, roundIndex.copyWith(j)],
            ),
            if (j != set.roundsCount - 1)
              restInterval.copyWith(
                isLast: set.roundsCount != 1 && j == set.roundsCount - 1,
                indexes: [if (sets.length > 1) setIndex, roundIndex.copyWith(j)],
              ),
            if (j == set.roundsCount - 1 && i != sets.length - 1) restAfterSet.copyWith(indexes: [setIndex]),
          ],
        );
      }
      intervals.addAll(setIntervals);
    }
    return Workout(intervals: intervals);
  }

  @computed
  WorkoutSettings get settings => WorkoutSettings(workRest: WorkRestSettings(workRests: sets));
}
