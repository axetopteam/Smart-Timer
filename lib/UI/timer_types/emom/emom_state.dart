import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/sdk/models/protos/emom/emom_extension.dart';
import 'package:smart_timer/sdk/models/protos/emom_settings/emom_settings.pb.dart';
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
  Workout get workout {
    final List<Interval> intervals = [];

    for (var i = 0; i < emomsCount; i++) {
      final emom = emoms[i];
      List<Interval> setIntervals = List.generate(
        emom.roundsCount,
        (index) => FiniteInterval(
          duration: emom.workTime,
          type: IntervalType.work,
          isLast: emom.roundsCount != 1 && index == emom.roundsCount - 1,
        ),
      );
      if (i != emomsCount - 1) {
        setIntervals.add(
          FiniteInterval(
            duration: emom.restAfterSet,
            type: IntervalType.rest,
          ),
        );
      }

      intervals.addAll(setIntervals);
    }
    return Workout(intervals: intervals, description: _descriptionSolver);
  }

  @computed
  WorkoutSettings get settings => WorkoutSettings(emom: EmomSettings(emoms: emoms));

  String _descriptionSolver(int currentIndex) {
    var index = currentIndex;

    for (var emomIndex = 0; emomIndex < emomsCount; emomIndex++) {
      final emomRoundsCount = emoms[emomIndex].roundsCount;

      if (index < emomRoundsCount + 1) {
        final buffer = StringBuffer();
        if (emomsCount > 1) {
          buffer.write('EMOM ${emomIndex + 1}/$emomsCount');
          buffer.write('\n');
        }
        if (index < emomRoundsCount) {
          buffer.write('Round ${index + 1}/$emomRoundsCount');
        }
        return buffer.toString();
      }
      index -= (emomRoundsCount + 1);
    }

    return '';
  }
}
