import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/round.dart';

class Workout {
  Workout._(
    this.rounds,
    this.roundsCound,
  );
  final List<Round> rounds;
  final int roundsCound;

  factory Workout.withLauchRound(List<Round> rounds) {
    return Workout._(
      [
        Round([Interval(duration: const Duration(seconds: 4), type: IntervalType.prelaunch)]),
        ...rounds,
      ],
      rounds.length,
    );
  }
  // Duration launchCountdown;
}
