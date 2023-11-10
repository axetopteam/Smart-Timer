import 'package:smart_timer/sdk/models/workout_interval_type.dart';

import 'interval_index.dart';
export 'interval_index.dart';

sealed class Interval {
  Interval({
    required this.type,
    required this.indexes,
    this.isLast = false,
  });
  final IntervalType type;
  final bool isLast;
  final List<IntervalIndex> indexes;

  Duration currentTime({required DateTime startTime, required DateTime now});

  Duration pastTime({required DateTime startTime, required DateTime now}) {
    return now.difference(startTime);
  }
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

  Interval copyWith({List<IntervalIndex>? indexes}) {
    switch (this) {
      case FiniteInterval finiteInterval:
        return finiteInterval.copyWith(indexes: indexes);
      case TimeCapInterval timeCapInterval:
        return timeCapInterval.copyWith(indexes: indexes);
      case InfiniteInterval infiniteInterval:
        return infiniteInterval.copyWith(indexes: indexes);
      case RatioInterval ratioInterval:
        return ratioInterval.copyWith(indexes: indexes);
      case RepeatLastInterval repeatLastInterval:
        return repeatLastInterval.copyWith(indexes: indexes);
    }
  }
}

const negativeTime = Duration(seconds: -1);

class FiniteInterval extends Interval {
  FiniteInterval({
    required this.duration,
    required super.type,
    required super.indexes,
    super.isLast,
  });
  final Duration duration;

  @override
  Duration currentTime({required DateTime startTime, required DateTime now}) {
    final rest = (duration - now.difference(startTime));
    return rest > const Duration() ? rest : const Duration(seconds: -1);
  }

  FiniteInterval copyWith({bool? isLast, List<IntervalIndex>? indexes}) {
    return FiniteInterval(
      duration: duration,
      type: type,
      indexes: indexes ?? this.indexes,
      isLast: isLast ?? this.isLast,
    );
  }
}

class TimeCapInterval extends Interval {
  TimeCapInterval({
    required this.timeCap,
    required super.type,
    required super.indexes,
    super.isLast,
  });
  final Duration timeCap;

  @override
  Duration currentTime({required DateTime startTime, required DateTime now}) {
    final currentDuration = now.difference(startTime);
    return currentDuration < timeCap ? currentDuration : const Duration(seconds: -1);
  }

  TimeCapInterval copyWith({bool? isLast, List<IntervalIndex>? indexes}) {
    return TimeCapInterval(
      timeCap: timeCap,
      type: type,
      indexes: indexes ?? this.indexes,
      isLast: isLast ?? this.isLast,
    );
  }
}

class InfiniteInterval extends Interval {
  InfiniteInterval({
    required super.type,
    required super.indexes,
    super.isLast,
  });

  @override
  Duration currentTime({required DateTime startTime, required DateTime now}) {
    final currentDuration = now.difference(startTime);
    return currentDuration;
  }

  InfiniteInterval copyWith({bool? isLast, List<IntervalIndex>? indexes}) {
    return InfiniteInterval(
      type: type,
      indexes: indexes ?? this.indexes,
      isLast: isLast ?? this.isLast,
    );
  }
}

class RatioInterval extends Interval {
  RatioInterval({
    required this.ratio,
    required super.type,
    required super.indexes,
    super.isLast,
  });

  final double ratio;

  @override
  Duration currentTime({required DateTime startTime, required DateTime now}) {
    final currentDuration = now.difference(startTime);
    return currentDuration;
  }

  RatioInterval copyWith({bool? isLast, List<IntervalIndex>? indexes}) {
    return RatioInterval(
      ratio: ratio,
      type: type,
      indexes: indexes ?? this.indexes,
      isLast: isLast ?? this.isLast,
    );
  }
}

class RepeatLastInterval extends Interval {
  RepeatLastInterval({
    required super.type,
    required super.indexes,
    super.isLast,
  });

  @override
  Duration currentTime({required DateTime startTime, required DateTime now}) {
    final currentDuration = now.difference(startTime);
    return currentDuration;
  }

  RepeatLastInterval copyWith({bool? isLast, List<IntervalIndex>? indexes}) {
    return RepeatLastInterval(
      type: type,
      indexes: indexes ?? this.indexes,
      isLast: isLast ?? this.isLast,
    );
  }
}
