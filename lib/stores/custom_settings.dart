import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/round.dart';
// import 'package:smart_timer/models/set.dart';
// import 'package:smart_timer/models/workout.dart';

part 'custom_settings.g.dart';

class CustomSettings = CustomSettingsBase with _$CustomSettings;

abstract class CustomSettingsBase with Store {
  @observable
  var roundsCounts = ObservableList.of([1]);

  @observable
  ObservableList<Round> rounds = ObservableList.of([
    Round(
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
    if (roundIndex >= rounds.length || intervalIndex >= rounds[roundIndex].intervals.length) return;
    final interval = Interval(
      duration: duration,
      type: IntervalType.work,
      isCountdown: true,
    );
    rounds[roundIndex].intervals[intervalIndex] = interval;
  }

  @action
  void addRound() {
    final intervals = ObservableList.of(rounds.last.intervals);
    rounds.add(Round(intervals));
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
    final interval = rounds.last.intervals.last;
    rounds[roundIndex].intervals.add(interval);
    // print(intervals.length);
  }

  @action
  void deleteInterval(int roundIndex, int intervalIndex) {
    if (roundIndex >= rounds.length || rounds[roundIndex].intervals.length < 2 || intervalIndex >= rounds[roundIndex].intervals.length) return;
    rounds[roundIndex].intervals.removeAt(intervalIndex);
  }
}
