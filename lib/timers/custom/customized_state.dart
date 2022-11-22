import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';

part 'customized_state.g.dart';

class CustomizedState extends CustomizedStateBase with _$CustomizedState {
  CustomizedState({ObservableList<int>? roundsCounts, ObservableList<ObservableList<Duration>>? sets})
      : super(
          roundsCounts: roundsCounts,
          sets: sets,
        );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> setsJson = {};
    for (int i = 0; i < sets.length; i++) {
      final roundJson = {};
      for (int j = 0; j < sets[i].length; j++) {
        roundJson.addAll({'$j': sets[i][j].inSeconds});
      }
      setsJson.addAll({'$i': roundJson});
    }

    Map<String, dynamic> roundsCountsJson = {};
    for (int i = 0; i < roundsCounts.length; i++) {
      roundsCountsJson.addAll({'$i': roundsCounts[i]});
    }

    return {'sets': setsJson, 'roundsCounts': roundsCountsJson};
  }

  factory CustomizedState.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> setsJson = json['sets'];
    Map<String, dynamic> roundsCountsJson = json['roundsCounts'];

    ObservableList<ObservableList<Duration>> sets = ObservableList<ObservableList<Duration>>();
    for (int i = 0; i < setsJson.length; i++) {
      List<Duration> round =
          (setsJson['$i'] as Map<String, dynamic>).values.map((value) => Duration(seconds: value as int)).toList();
      sets.add(ObservableList.of(round));
    }

    final roundsCounts = roundsCountsJson.values.map((e) => e as int);

    return CustomizedState(sets: sets, roundsCounts: ObservableList.of(roundsCounts));
  }
}

abstract class CustomizedStateBase with Store {
  CustomizedStateBase({ObservableList<int>? roundsCounts, ObservableList<ObservableList<Duration>>? sets})
      : roundsCounts = roundsCounts ?? ObservableList<int>.of([1]),
        sets = sets ??
            ObservableList.of(
              [
                ObservableList.of(
                  [
                    const Duration(minutes: 1),
                    const Duration(minutes: 2),
                    const Duration(minutes: 3),
                  ],
                ),
              ],
            );

  @observable
  ObservableList<int> roundsCounts;

  @observable
  ObservableList<ObservableList<Duration>> sets;

  WorkoutSet get workout {
    final List<WorkoutSet> workoutList = [];
    for (int i = 0; i < sets.length; i++) {
      final intervals = sets[i]
          .map(
            (duration) => Interval(type: IntervalType.work, duration: duration),
          )
          .toList();
      final round = WorkoutSet(intervals);

      final lastIntervals = List.of(intervals);
      lastIntervals.last = lastIntervals.last.copyWith(isLast: true);
      final lastRound = WorkoutSet(lastIntervals);

      final List<WorkoutSet> setsList = [];
      for (int j = 0; j < roundsCounts[i]; j++) {
        if (i == sets.length - 1 && j == roundsCounts[i] - 1) {
          setsList.add(lastRound);
        } else {
          setsList.add(round);
        }
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
    sets[setIndex][intervalIndex] = duration;
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
    final interval = sets[setIndex].last;
    sets[setIndex].add(interval);
  }

  @action
  void deleteInterval(int setIndex, int intervalIndex) {
    if (setIndex >= sets.length || sets[setIndex].length < 2 || intervalIndex >= sets[setIndex].length) return;
    sets[setIndex].removeAt(intervalIndex);
  }
}
