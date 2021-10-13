import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/round.dart';
import 'package:smart_timer/models/set.dart';

class Workout {
  Workout._(
    this.sets,
    // this.roundsCound,
  );
  final List<WorkoutSet> sets;
  // final List<Round> rounds;
  // int get roundsCound => rounds.length;

  factory Workout.withLauchRound(List<Round> rounds) {
    final firstRoundIntervals = List<Interval>.from(rounds.first.intervals);
    final launchInterval = Interval(duration: const Duration(seconds: 4), type: IntervalType.countdown);
    firstRoundIntervals.insert(
      0,
      launchInterval,
    );
    rounds[0] = Round(firstRoundIntervals);

    return Workout._(
      [WorkoutSet(rounds)],
    );
  }
  // Duration launchCountdown;
}
