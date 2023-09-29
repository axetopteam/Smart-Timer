import 'package:mobx/mobx.dart';
import 'package:smart_timer/sdk/models/protos/afap/afap_extension.dart';
import 'package:smart_timer/sdk/models/workout_interval.dart';
import 'package:smart_timer/sdk/models/workout_interval_type.dart';
import 'package:smart_timer/sdk/models/workout_set.dart';

export 'package:smart_timer/sdk/models/protos/afap/afap_extension.dart';

part 'afap_state.g.dart';

class AfapState = AfapStateBase with _$AfapState;

abstract class AfapStateBase with Store {
  AfapStateBase({List<Afap>? afaps}) : afaps = ObservableList.of(afaps ?? [AfapX.defaultValue]);

  ObservableList<Afap> afaps;

  @computed
  int get afapsCount => afaps.length;

  @action
  void setTimeCap(int afapIndex, Duration duration) {
    if (afapIndex < 0 || afapIndex >= afapsCount) return;

    afaps[afapIndex] = afaps[afapIndex].copyWithNewValue(timeCap: duration);
  }

  @action
  void setRestTime(int afapIndex, Duration duration) {
    if (afapIndex < 0 || afapIndex >= afapsCount) return;

    afaps[afapIndex] = afaps[afapIndex].copyWithNewValue(restTime: duration);

    if (afapIndex == afapsCount - 2) {
      afaps[afapIndex + 1] = afaps[afapIndex + 1].copyWithNewValue(restTime: duration);
    }
  }

  @action
  void setNoTimeCap(int afapIndex, bool noTimeCap) {
    if (afapIndex < 0 || afapIndex >= afapsCount) return;

    afaps[afapIndex] = afaps[afapIndex].copyWithNewValue(noTimeCap: noTimeCap);
  }

  @action
  void addAfap() {
    final lastAfapCopy = afaps.last.copyWithNewValue();
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
