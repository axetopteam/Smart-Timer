import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/sdk/models/protos/emom/emom_extension.dart';
import 'package:smart_timer/sdk/models/protos/emom_settings/emom_settings.pb.dart';
import 'package:smart_timer/sdk/models/workout_interval.dart';
import 'package:smart_timer/sdk/models/workout_interval_type.dart';
import 'package:smart_timer/sdk/sdk_service.dart';

import '../timer_settings_interface.dart';

export 'package:smart_timer/sdk/models/protos/emom/emom_extension.dart';
export 'package:smart_timer/sdk/models/protos/emom_settings/emom_settings.pb.dart';

part 'emom_state.g.dart';

class EmomState = EmomStateBase with _$EmomState implements TimerSettingsInterface;

abstract class EmomStateBase with Store {
  EmomStateBase({List<Emom>? emoms}) : emoms = ObservableList.of(emoms ?? [EmomX.defaultValue]);

  final type = TimerType.emom;

  final ObservableList<Emom> emoms;

  @computed
  int get emomsCount => emoms.length;

  @action
  void setRounds(int emomIndex, int value) {
    final emom = emoms[emomIndex];
    emoms[emomIndex] = emom.copyWithNewValue(roundsCount: value);
  }

  @action
  void setWorkTime(int emomIndex, Duration duration) {
    final emom = emoms[emomIndex];
    emoms[emomIndex] = emom.copyWithNewValue(workTime: duration);
  }

  @action
  void setRestAfterSet(int emomIndex, Duration duration) {
    final emom = emoms[emomIndex];
    emoms[emomIndex] = emom.copyWithNewValue(restAfterSet: duration);
    if (emomIndex == emomsCount - 2) {
      emoms[emomIndex + 1] = emoms[emomIndex + 1].copyWithNewValue(restAfterSet: duration);
    }
  }

  @action
  void addEmom() {
    final newEmom = emoms.last.copyWithNewValue();
    emoms.add(newEmom);
  }

  @action
  void deleteEmom(int emomIndex) {
    emoms.removeAt(emomIndex);
  }

  Future<void> saveToFavorites({required String name, required String description}) async {
    return GetIt.I<SdkService>().addToFavorite(
      settings: settings,
      name: name,
      description: description,
    );
  }

  @computed
  WorkoutSet get workout {
    List<WorkoutSet> sets = [];
    for (var i = 0; i < emomsCount; i++) {
      final emom = emoms[i];
      List<WorkoutInterval> intervals = List.generate(
        emom.roundsCount,
        (index) => WorkoutInterval(
          duration: emom.workTime,
          type: WorkoutIntervalType.work,
          isLast: emom.roundsCount != 1 && index == emom.roundsCount - 1,
        ),
      );
      if (i != emomsCount - 1) {
        intervals.add(WorkoutInterval(
          duration: emom.restAfterSet,
          type: WorkoutIntervalType.rest,
        ));
      }
      String? roundDescriptionSolver(int currentIndex) =>
          (currentIndex <= emom.roundsCount) ? 'ROUND $currentIndex/${emom.roundsCount}' : null;

      final set = WorkoutSet(intervals, descriptionSolver: roundDescriptionSolver);

      sets.add(set);
    }

    return WorkoutSet(sets, descriptionSolver: _setDescriptionSolver);
  }

  @computed
  WorkoutSettings get settings => WorkoutSettings(emom: EmomSettings(emoms: emoms));

  String _setDescriptionSolver(int currentIndex) {
    return 'SET $currentIndex/$emomsCount';
  }
}
