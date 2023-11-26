import 'package:collection/collection.dart';
import 'package:smart_timer/sdk/models/unsuitable_type_error.dart';

import '../activity_type.dart';
import 'interval_index.dart';

export '../activity_type.dart';
export 'interval_index.dart';

sealed class Interval {
  Interval({
    required this.activityType,
    required this.indexes,
    this.isLast = false,
  });
  final ActivityType activityType;
  final bool isLast;
  final List<IntervalIndex> indexes;

  Duration currentTime({required DateTime startTime, required DateTime now});

  Duration pastTime({required DateTime startTime, required DateTime now}) {
    return now.difference(startTime);
  }

  Map<String, dynamic> toJson();

  factory Interval.fromJson(Map<String, dynamic> json) {
    final type = json['type'] ?? (throw UnsuitableTypeError('interval type is null'));
    switch (type) {
      case 'finite':
        return FiniteInterval.fromJson(json);
      case 'infinite':
        return InfiniteInterval.fromJson(json);
      case 'ratio':
        return RatioInterval.fromJson(json);
      case 'repeatLast':
        return RepeatLastInterval.fromJson(json);
    }
    throw UnsuitableTypeError('interval type: $type is unknown');
  }
}

extension IntervalX on Interval {
  Duration? get totalDuration {
    switch (this) {
      case FiniteInterval finiteInterval:
        return finiteInterval.duration;
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
      case InfiniteInterval infiniteInterval:
        return infiniteInterval.copyWith(indexes: indexes);
      case RatioInterval ratioInterval:
        return ratioInterval.copyWith(indexes: indexes);
      case RepeatLastInterval repeatLastInterval:
        return repeatLastInterval.copyWith(indexes: indexes);
    }
  }
}

class FiniteInterval extends Interval {
  FiniteInterval({
    required this.duration,
    required this.isReverse,
    this.canBeCompleteEarlier = false,
    required super.activityType,
    required super.indexes,
    super.isLast,
  });
  final Duration duration;
  final bool isReverse;
  final bool canBeCompleteEarlier;

  @override
  Duration currentTime({required DateTime startTime, required DateTime now}) {
    if (isReverse) {
      final rest = (duration - now.difference(startTime));
      return rest > const Duration() ? rest : const Duration(seconds: -1);
    } else {
      final currentDuration = now.difference(startTime);
      return currentDuration < duration ? currentDuration : const Duration(seconds: -1);
    }
  }

  FiniteInterval copyWith({bool? isLast, List<IntervalIndex>? indexes}) {
    return FiniteInterval(
      duration: duration,
      isReverse: isReverse,
      canBeCompleteEarlier: canBeCompleteEarlier,
      activityType: activityType,
      indexes: indexes ?? this.indexes,
      isLast: isLast ?? this.isLast,
    );
  }

  factory FiniteInterval.fromJson(Map<String, dynamic> json) {
    final duration = Duration(milliseconds: json['duration'] ?? (throw UnsuitableTypeError('duration is null')));
    final isReverse = json['isReverse'] ?? (throw UnsuitableTypeError('isReverse is null'));
    final canBeCompleteEarlier =
        json['canBeCompleteEarlier'] ?? (throw UnsuitableTypeError('canBeCompleteEarlier is null'));
    final activityTypeName = json['activityType'] ?? (throw UnsuitableTypeError('activityType is null'));
    final activityType = ActivityType.values.firstWhereOrNull((element) => element.name == activityTypeName) ??
        (throw UnsuitableTypeError('activityType: $activityTypeName is unknown'));
    final indexes = json['indexes'] ?? (throw UnsuitableTypeError('indexes is null'));
    final indexesList = indexes is List
        ? indexes.map((e) => IntervalIndex.fromJson(e)).toList()
        : (throw UnsuitableTypeError('indexes is not a list'));
    final isLast = json['isLast'] ?? (throw UnsuitableTypeError('isLast is null'));

    return FiniteInterval(
      duration: duration,
      isReverse: isReverse,
      canBeCompleteEarlier: canBeCompleteEarlier,
      activityType: activityType,
      indexes: indexesList,
      isLast: isLast,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'finite',
      'duration': duration.inMilliseconds,
      'canBeCompleteEarlier': canBeCompleteEarlier,
      'activityType': activityType.name,
      'isReverse': isReverse,
      'indexes': indexes.map((e) => e.toJson()).toList(),
      'isLast': isLast,
    };
  }
}

class InfiniteInterval extends Interval {
  InfiniteInterval({
    required super.activityType,
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
      activityType: activityType,
      indexes: indexes ?? this.indexes,
      isLast: isLast ?? this.isLast,
    );
  }

  factory InfiniteInterval.fromJson(Map<String, dynamic> json) {
    final activityTypeName = json['activityType'] ?? (throw UnsuitableTypeError('activityType is null'));
    final activityType = ActivityType.values.firstWhereOrNull((element) => element.name == activityTypeName) ??
        (throw UnsuitableTypeError('activityType: $activityTypeName is unknown'));
    final indexes = json['indexes'] ?? (throw UnsuitableTypeError('indexes is null'));
    final indexesList = indexes is List
        ? indexes.map((e) => IntervalIndex.fromJson(e)).toList()
        : (throw UnsuitableTypeError('indexes is not a list'));
    final isLast = json['isLast'] ?? (throw UnsuitableTypeError('isLast is null'));

    return InfiniteInterval(
      activityType: activityType,
      indexes: indexesList,
      isLast: isLast,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'infinite',
      'activityType': activityType.name,
      'indexes': indexes.map((e) => e.toJson()).toList(),
      'isLast': isLast,
    };
  }
}

class RatioInterval extends Interval {
  RatioInterval({
    required this.ratio,
    required super.activityType,
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
      activityType: activityType,
      indexes: indexes ?? this.indexes,
      isLast: isLast ?? this.isLast,
    );
  }

  factory RatioInterval.fromJson(Map<String, dynamic> json) {
    final ratio = json['ratio'] ?? (throw UnsuitableTypeError('ratio is null'));
    final activityTypeName = json['activityType'] ?? (throw UnsuitableTypeError('activityType is null'));
    final activityType = ActivityType.values.firstWhereOrNull((element) => element.name == activityTypeName) ??
        (throw UnsuitableTypeError('activityType: $activityTypeName is unknown'));
    final indexes = json['indexes'] ?? (throw UnsuitableTypeError('indexes is null'));
    final indexesList = indexes is List
        ? indexes.map((e) => IntervalIndex.fromJson(e)).toList()
        : (throw UnsuitableTypeError('indexes is not a list'));
    final isLast = json['isLast'] ?? (throw UnsuitableTypeError('isLast is null'));

    return RatioInterval(
      ratio: ratio,
      activityType: activityType,
      indexes: indexesList,
      isLast: isLast,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'ratio',
      'ratio': ratio,
      'activityType': activityType.name,
      'indexes': indexes.map((e) => e.toJson()).toList(),
      'isLast': isLast,
    };
  }
}

class RepeatLastInterval extends Interval {
  RepeatLastInterval({
    required super.activityType,
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
      activityType: activityType,
      indexes: indexes ?? this.indexes,
      isLast: isLast ?? this.isLast,
    );
  }

  factory RepeatLastInterval.fromJson(Map<String, dynamic> json) {
    final activityTypeName = json['activityType'] ?? (throw UnsuitableTypeError('activityType is null'));
    final activityType = ActivityType.values.firstWhereOrNull((element) => element.name == activityTypeName) ??
        (throw UnsuitableTypeError('activityType: $activityTypeName is unknown'));
    final indexes = json['indexes'] ?? (throw UnsuitableTypeError('indexes is null'));
    final indexesList = indexes is List
        ? indexes.map((e) => IntervalIndex.fromJson(e)).toList()
        : (throw UnsuitableTypeError('indexes is not a list'));
    final isLast = json['isLast'] ?? (throw UnsuitableTypeError('isLast is null'));

    return RepeatLastInterval(
      activityType: activityType,
      indexes: indexesList,
      isLast: isLast,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'repeatLast',
      'activityType': activityType.name,
      'indexes': indexes.map((e) => e.toJson()).toList(),
      'isLast': isLast,
    };
  }
}
