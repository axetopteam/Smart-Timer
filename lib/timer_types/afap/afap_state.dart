import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/sdk/models/workout_interval.dart';
import 'package:smart_timer/sdk/models/workout_interval_type.dart';
import 'package:smart_timer/sdk/models/workout_set.dart';

import 'afap.dart';
export 'afap.dart';

part 'afap_state.g.dart';

@JsonSerializable()
class AfapState extends AfapStateBase with _$AfapState {
  AfapState({List<Afap>? afaps}) : super(afaps: afaps);

  Map<String, dynamic> toJson() => _$AfapStateToJson(this);

  factory AfapState.fromJson(Map<String, dynamic> json) => _$AfapStateFromJson(json);
}

abstract class AfapStateBase with Store {
  AfapStateBase({List<Afap>? afaps}) : afaps = ObservableList.of(afaps ?? [Afap.defaultValue]);

  ObservableList<Afap> afaps;

  @computed
  int get afapsCount => afaps.length;

  @action
  void setTimeCap(int afapIndex, Duration duration) {
    if (afapIndex < 0 || afapIndex >= afapsCount) return;

    afaps[afapIndex] = afaps[afapIndex].copyWith(timeCap: duration);
  }

  @action
  void setRestTime(int afapIndex, Duration duration) {
    if (afapIndex < 0 || afapIndex >= afapsCount) return;

    afaps[afapIndex] = afaps[afapIndex].copyWith(restTime: duration);

    if (afapIndex == afapsCount - 2) {
      afaps[afapIndex + 1] = afaps[afapIndex + 1].copyWith(restTime: duration);
    }
  }

  @action
  void setNoTimeCap(int afapIndex, bool noTimeCap) {
    if (afapIndex < 0 || afapIndex >= afapsCount) return;

    afaps[afapIndex] = afaps[afapIndex].copyWith(noTimeCap: noTimeCap);
  }

  @action
  void addAfap() {
    final lastAfapCopy = afaps.last.copyWith();
    afaps.add(lastAfapCopy);
  }

  @action
  void deleteAfap(int afapIndex) {
    afaps.removeAt(afapIndex);
  }

  WorkoutSet get workout {
    final List<WorkoutSet> sets = [];
    for (int i = 0; i < afapsCount; i++) {
      final afap = afaps[i];
      final set = WorkoutSet(
        [
          WorkoutInterval(
            type: WorkoutIntervalType.work,
            duration: afap.noTimeCap ? null : afap.timeCap,
            isCountdown: false,
            isLast: afapsCount != 1 && i == afapsCount - 1,
          ),
          if (i != afapsCount - 1) WorkoutInterval(type: WorkoutIntervalType.rest, duration: afap.restTime),
        ],
      );
      sets.add(set);
    }

    return WorkoutSet(sets, descriptionSolver: _despriptionSolver);
  }

  String _despriptionSolver(int currentIndex) {
    return 'AFAP $currentIndex/$afapsCount';
  }
}
