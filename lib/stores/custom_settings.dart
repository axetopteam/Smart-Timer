import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';

part 'custom_settings.g.dart';

class CustomSettings = CustomSettingsBase with _$CustomSettings;

abstract class CustomSettingsBase with Store {
  @observable
  var roundsCounts = ObservableList.of([1]);

  @observable
  ObservableList<ObservableList<Interval>> sets = ObservableList.of(
    [
      ObservableList.of(
        [
          Interval(
            duration: const Duration(minutes: 1),
            type: IntervalType.work,
            isCountdown: true,
          ),
          Interval(
            duration: const Duration(minutes: 2),
            type: IntervalType.work,
            isCountdown: true,
          ),
          Interval(
            duration: const Duration(minutes: 3),
            type: IntervalType.work,
            isCountdown: true,
          ),
        ],
      ),
    ],
  );

  WorkoutSet get workout {
    final List<WorkoutSet> workoutList = [];
    for (int i = 0; i < sets.length; i++) {
      final round = WorkoutSet(sets[i]);
      final List<WorkoutSet> setsList = [];
      for (int j = 0; j < roundsCounts[i]; j++) {
        setsList.add(round);
      }
      final set = WorkoutSet(setsList);
      workoutList.add(set);
    }
    return WorkoutSet(workoutList).copy();
  }

  @action
  void setRounds(int setIndex, int value) {
    roundsCounts[setIndex] = value;
  }

  @action
  void setInterval(int setIndex, int intervalIndex, Duration duration) {
    if (setIndex >= sets.length || intervalIndex >= sets[setIndex].length) return;
    final interval = Interval(
      duration: duration,
      type: IntervalType.work,
      isCountdown: true,
    );
    sets[setIndex][intervalIndex] = interval;
  }

  @action
  void addRound() {
    final intervals = ObservableList.of(sets.last);
    sets.add(intervals);
    final counts = roundsCounts.last;
    roundsCounts.add(counts);
  }

  @action
  void deleteRound(int setIndex) {
    sets.removeAt(setIndex);
    roundsCounts.removeAt(setIndex);
    // print(intervals.length);
  }

  @action
  void addInterval(int setIndex) {
    final interval = sets[setIndex].last.copy();
    sets[setIndex].add(interval);
  }

  @action
  void deleteInterval(int setIndex, int intervalIndex) {
    if (setIndex >= sets.length || sets[setIndex].length < 2 || intervalIndex >= sets[setIndex].length) return;
    sets[setIndex].removeAt(intervalIndex);
  }
}
