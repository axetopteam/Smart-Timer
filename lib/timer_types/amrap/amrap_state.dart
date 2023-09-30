import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/sdk/models/protos/amrap/amrap_extension.dart';
import 'package:smart_timer/sdk/models/protos/amrap_settings/amrap_settings.pbserver.dart';
import 'package:smart_timer/sdk/models/workout_interval.dart';
import 'package:smart_timer/sdk/models/workout_interval_type.dart';
import 'package:smart_timer/sdk/models/workout_set.dart';
import 'package:smart_timer/sdk/sdk_service.dart';

// import 'amrap.dart';
// export 'amrap.dart';

part 'amrap_state.g.dart';

class AmrapState extends AmrapStateBase with _$AmrapState {
  AmrapState({List<Amrap>? amraps}) : super(amraps: amraps);
}

abstract class AmrapStateBase with Store {
  AmrapStateBase({List<Amrap>? amraps}) : amraps = ObservableList.of(amraps ?? [AmrapX.defaultValue]);

  ObservableList<Amrap> amraps;

  @computed
  int get amrapsCount => amraps.length;

  @action
  void setWorkTime(int amrapIndex, Duration duration) {
    if (amrapIndex < 0 || amrapIndex >= amrapsCount) return;

    amraps[amrapIndex] = amraps[amrapIndex].copyWithNewValue(workTime: duration);
  }

  @action
  void setRestTime(int amrapIndex, Duration duration) {
    if (amrapIndex < 0 || amrapIndex >= amrapsCount) return;

    amraps[amrapIndex] = amraps[amrapIndex].copyWithNewValue(restTime: duration);
    if (amrapIndex == amrapsCount - 2) {
      amraps[amrapIndex + 1] = amraps[amrapIndex + 1].copyWithNewValue(restTime: duration);
    }
  }

  @action
  void addAmrap() {
    final lastAmrapCopy = amraps.last.copyWithNewValue();
    amraps.add(lastAmrapCopy);
  }

  @action
  void deleteAmrap(int amrapIndex) {
    amraps.removeAt(amrapIndex);
  }

  Future<void> saveToFavorites(String name, String description) async {
    return GetIt.I<SdkService>().addToFavorite(
      type: TimerType.amrap,
      workout: AmrapSettings(amraps: amraps),
      name: name,
      description: description,
    );
  }

  WorkoutSet get workout {
    final List<WorkoutSet> sets = [];
    for (int i = 0; i < amrapsCount; i++) {
      final amrap = WorkoutSet(
        [
          WorkoutInterval(
            type: WorkoutIntervalType.work,
            duration: amraps[i].workTime,
            isLast: amrapsCount != 1 && i == amrapsCount - 1,
          ),
          if (i != amrapsCount - 1) WorkoutInterval(type: WorkoutIntervalType.rest, duration: amraps[i].restTime),
        ],
      );
      sets.add(amrap);
    }

    return WorkoutSet(sets, descriptionSolver: _descriptionSolver);
  }

  String _descriptionSolver(int currentAmrapIndex) {
    return 'AMRAP $currentAmrapIndex/$amrapsCount';
  }
}
