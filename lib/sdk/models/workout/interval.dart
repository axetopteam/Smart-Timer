import 'package:smart_timer/sdk/models/workout_interval_type.dart';

sealed class Interval {
  Interval({required this.type, this.isLast = false});
  final IntervalType type;
  final bool isLast;
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
      case RatioInterval():
      case RepeatLastInterval():
        return null;
    }
  }
}

const negativeTime = Duration(seconds: -1);

class FiniteInterval extends Interval {
  FiniteInterval({required this.duration, required super.type, super.isLast});
  final Duration duration;

  @override
  Duration currentTime({required DateTime startTime, required DateTime now}) {
    final rest = (duration - now.difference(startTime));
    return rest > const Duration() ? rest : const Duration(seconds: -1);
  }

  FiniteInterval copyWith({bool? isLast}) {
    return FiniteInterval(
      duration: duration,
      type: type,
      isLast: isLast ?? this.isLast,
    );
  }
}

class TimeCapInterval extends Interval {
  TimeCapInterval({required this.timeCap, required super.type, super.isLast});
  final Duration timeCap;

  @override
  Duration currentTime({required DateTime startTime, required DateTime now}) {
    final currentDuration = now.difference(startTime);
    return currentDuration < timeCap ? currentDuration : const Duration(seconds: -1);
  }
}

class InfiniteInterval extends Interval {
  InfiniteInterval({required super.type, super.isLast});

  @override
  Duration currentTime({required DateTime startTime, required DateTime now}) {
    final currentDuration = now.difference(startTime);
    return currentDuration;
  }

  InfiniteInterval copyWith({bool? isLast}) {
    return InfiniteInterval(
      type: type,
      isLast: isLast ?? this.isLast,
    );
  }
}

class RatioInterval extends Interval {
  RatioInterval({
    required this.ratio,
    required super.type,
    super.isLast,
  });

  final double ratio;

  @override
  Duration currentTime({required DateTime startTime, required DateTime now}) {
    final currentDuration = now.difference(startTime);
    return currentDuration;
  }
}

class RepeatLastInterval extends Interval {
  RepeatLastInterval({
    required super.type,
    super.isLast,
  });

  @override
  Duration currentTime({required DateTime startTime, required DateTime now}) {
    final currentDuration = now.difference(startTime);
    return currentDuration;
  }
}
