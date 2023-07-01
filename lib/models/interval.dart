import 'package:jiffy/jiffy.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interfaces/interval_interface.dart';
import 'package:smart_timer/services/audio_service.dart';

import 'interval_type.dart';

part 'interval.g.dart';

class Interval = IntervalBase with _$Interval;

abstract class IntervalBase with Store implements IntervalInterface {
  IntervalBase({
    this.duration,
    required this.type,
    this.isCountdown = true,
    this.isReverse = false,
    this.reverseRatio = 1,
    this.isLast = false,
  })  : assert(!isCountdown || duration != null || isReverse),
        _currentTime = isCountdown ? duration : const Duration(),
        restDuration = duration;

  final IntervalType type;
  final bool isCountdown;
  final bool isReverse;
  final int reverseRatio;
  final bool isLast;

  DateTime? startTimeUtc;

  Duration? duration;
  Duration? restDuration;

  Duration? get endReminderStart {
    if (isCountdown) {
      return const Duration(seconds: 3);
    } else {
      return duration != null ? duration! - const Duration(seconds: 3) : null;
    }
  }

  @computed
  bool get isFirstSecond {
    // if (type == IntervalType.countdown) return false;
    if (isCountdown) {
      return duration != null
          ? (currentTime?.inSeconds == duration!.inSeconds - 1 || currentTime?.inSeconds == duration!.inSeconds)
          : false;
    } else {
      return currentTime?.inSeconds == 0;
    }
  }

  Duration offset = const Duration();

  @observable
  Duration? _currentTime;
  @override
  Duration? get currentTime => _currentTime;

  @override
  DateTime? get finishTimeUtc {
    if (startTimeUtc != null && restDuration != null) {
      return startTimeUtc!.add(restDuration!);
    }
    return null;
  }

  @override
  @computed
  Map<int, List<int>> get indexes {
    return {
      0: [1, 1]
    };
  }

  @override
  IntervalInterface get currentInterval => this;

  @override
  IntervalInterface? get nextInterval => null;

  @override
  Map<DateTime, SoundType> get reminders {
    Map<DateTime, SoundType> reminders = {};
    if (finishTimeUtc != null && duration! > const Duration(seconds: 29)) {
      reminders.addAll({
        finishTimeUtc!.subtract(
          Duration(seconds: (duration!.inSeconds / 2).round()),
        ): SoundType.halfTime,
      });
    }

    reminders.addAll({
      if (finishTimeUtc != null && duration! > const Duration(seconds: 10))
        finishTimeUtc!.subtract(const Duration(seconds: 10)): SoundType.tenSeconds,
      if (finishTimeUtc != null) finishTimeUtc!.subtract(const Duration(seconds: 3)): SoundType.countdown,
      if (isLast && startTimeUtc != null) startTimeUtc!.add(const Duration(milliseconds: 500)): SoundType.lastRound,
    });

    return reminders;
  }

  @override
  @action
  void setDuration({Duration? newDuration}) {
    // if (duration != null) return;
    if (newDuration != null) {
      duration = newDuration;
      restDuration = newDuration;
    } else {
      duration = _currentTime;
      restDuration = _currentTime! - offset;
    }
  }

  @override
  bool get isEnded {
    if (currentTime == null || duration == null) return false;
    return (isCountdown && currentTime! <= const Duration()) || (!isCountdown && currentTime! >= duration!);
  }

  @override
  @action
  void start(DateTime nowUtc) {
    startTimeUtc = nowUtc;
  }

  @override
  @action
  void pause() {
    startTimeUtc = null;
    if (duration != null && currentTime != null) {
      restDuration = isCountdown ? currentTime : duration! - currentTime!;
    }

    offset = _currentTime ?? const Duration();
  }

  @action
  void reset() {
    startTimeUtc = null;
    restDuration = duration;
    _currentTime = isCountdown ? duration : const Duration();
  }

  @override
  @action
  void tick(DateTime nowUtc) {
    if (isEnded) return;

    if (isCountdown) {
      _currentTime = finishTimeUtc!.difference(nowUtc);
    } else {
      _currentTime = offset + nowUtc.difference(startTimeUtc!);
    }
  }

  @override
  Interval copy() {
    return Interval(
      duration: duration,
      type: type,
      isCountdown: isCountdown,
      isReverse: isReverse,
      reverseRatio: reverseRatio,
      isLast: isLast,
    );
  }

  Interval copyWith({bool? isLast}) {
    return Interval(
      duration: duration,
      type: type,
      isCountdown: isCountdown,
      isReverse: isReverse,
      reverseRatio: reverseRatio,
      isLast: isLast ?? this.isLast,
    );
  }

  @override
  String description() {
    return '''
    Interval. 
    Start: ${Jiffy(startTimeUtc).Hms}
    Duration: $duration
    Finish: ${Jiffy(finishTimeUtc).Hms}${isLast ? '\nisLast: $isLast' : ''}
    ''';
  }
}
