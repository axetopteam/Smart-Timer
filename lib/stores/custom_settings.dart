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
  ObservableList<WorkoutSet> rounds = ObservableList.of([
    WorkoutSet(
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
    )
  ]);

  // @computed
  // Workout get workout {
  //   ObservableList<WorkoutSet> sets = ObservableList<WorkoutSet>();

  //   for (int i = 0; i < roundsCounts.length; i++) {
  //     ObservableList<Round> setRounds = ObservableList<Round>();
  //     for (int j = 0; j < roundsCounts[i]; j++) {
  //       setRounds.add(rounds[i]);
  //     }
  //     sets.add(WorkoutSet(setRounds));
  //   }
  //   // return Workout.withCountdownInterval2(sets);
  //   return Workout(sets);
  // }

  @action
  void setRounds(int roundsIndex, int value) {
    roundsCounts[roundsIndex] = value;
  }

  @action
  void setInterval(int roundIndex, int intervalIndex, Duration duration) {
    if (roundIndex >= rounds.length || intervalIndex >= rounds[roundIndex].sets.length) return;
    final interval = Interval(
      duration: duration,
      type: IntervalType.work,
      isCountdown: true,
    );
    rounds[roundIndex].sets[intervalIndex] = interval;
  }

  @action
  void addRound() {
    final intervals = ObservableList.of(rounds.last.sets);
    rounds.add(WorkoutSet(intervals));
    final counts = roundsCounts.last;
    roundsCounts.add(counts);
    // print(intervals.length);
  }

  @action
  void deleteRound(int roundIndex) {
    rounds.removeAt(roundIndex);
    roundsCounts.removeAt(roundIndex);
    // print(intervals.length);
  }

  @action
  void addInterval(int roundIndex) {
    final interval = rounds.last.sets.last;
    rounds[roundIndex].sets.add(interval);
    // print(intervals.length);
  }

  @action
  void deleteInterval(int roundIndex, int intervalIndex) {
    if (roundIndex >= rounds.length || rounds[roundIndex].sets.length < 2 || intervalIndex >= rounds[roundIndex].sets.length) return;
    rounds[roundIndex].sets.removeAt(intervalIndex);
  }
}
