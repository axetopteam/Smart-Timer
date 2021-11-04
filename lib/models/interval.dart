import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interfaces/interval_interface.dart';
import 'package:smart_timer/models/remiders_type.dart';

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
  })  : assert(!isCountdown || duration != null || isReverse),
        _currentTime = isCountdown ? duration : Duration(),
        restDuration = duration;

  final IntervalType type;
  final bool isCountdown;
  final bool isReverse;
  final int reverseRatio;

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
  bool get isLast => true;

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
  bool get isEnded => (isCountdown && currentTime == const Duration()) || (!isCountdown && currentTime == duration);

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
    );
  }

  @override
  String description() {
    return 'Interval. Start: $startTimeUtc\nDuration: $duration\nFinish: $finishTimeUtc';
  }
}
