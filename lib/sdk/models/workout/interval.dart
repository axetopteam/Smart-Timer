import 'package:smart_timer/sdk/models/workout_interval_type.dart';

sealed class Interval {
  Interval({required this.type});
  final IntervalType type;
  Duration currentTime({required DateTime startTime, required DateTime now});
}

extension IntervalX on Interval {
  Duration? get totalDuration {
    switch (this) {
      case FiniteInterval finiteInterval:
        return finiteInterval.duration;
      case TimeCapInterval timeCapInterval:
        return timeCapInterval.timeCap;
      case InfiniteInterval():
        return null;
    }
  }
}

class FiniteInterval extends Interval {
  FiniteInterval({required this.duration, required super.type});
  final Duration duration;

  @override
  Duration currentTime({required DateTime startTime, required DateTime now}) {
    final rest = (duration - now.difference(startTime));
    return rest > const Duration() ? rest : const Duration();
  }
}

class TimeCapInterval extends Interval {
  TimeCapInterval({required this.timeCap, required super.type});
  final Duration timeCap;

  @override
  Duration currentTime({required DateTime startTime, required DateTime now}) {
    final currentDuration = now.difference(startTime);
    return currentDuration <= timeCap ? currentDuration : const Duration();
  }
}

class InfiniteInterval extends Interval {
  InfiniteInterval({required super.type});

  @override
  Duration currentTime({required DateTime startTime, required DateTime now}) {
    final currentDuration = now.difference(startTime);
    return currentDuration;
  }
}
