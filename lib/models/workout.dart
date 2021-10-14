import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/round.dart';
import 'package:smart_timer/models/set.dart';

class Workout {
  Workout._(
    this.sets,
  );
  @observable
  final ObservableList<WorkoutSet> sets;

  factory Workout.withCountdownInterval(List<Round> rounds) {
    final firstRoundIntervals = ObservableList<Interval>.of(rounds.first.intervals);
    final launchInterval = Interval(duration: const Duration(seconds: 4), type: IntervalType.countdown);
    firstRoundIntervals.insert(
      0,
      launchInterval,
    );
    rounds[0] = Round(firstRoundIntervals);

    return Workout._(ObservableList.of([
      WorkoutSet(
        ObservableList.of(rounds),
      ),
    ]));
  }

  factory Workout.withCountdownInterval2(List<WorkoutSet> sets) {
    final firstSetRounds = ObservableList<Round>.of(sets.first.rounds);
    final firstRoundIntervals = ObservableList<Interval>.of(firstSetRounds.first.intervals);
    final launchInterval = Interval(duration: const Duration(seconds: 4), type: IntervalType.countdown);
    firstRoundIntervals.insert(
      0,
      launchInterval,
    );
    final newRound = Round(firstRoundIntervals);
    firstSetRounds[0] = newRound;
    final newSet = WorkoutSet(firstSetRounds);

    sets[0] = newSet;

    return Workout._(
      ObservableList<WorkoutSet>.of(sets),
    );
  }
}
