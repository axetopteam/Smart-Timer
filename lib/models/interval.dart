import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interfaces/interval_interface.dart';

import 'interval_type.dart';

part 'interval.g.dart';

class Interval = IntervalBase with _$Interval;

abstract class IntervalBase with Store implements IntervalInterface {
  IntervalBase({
    this.duration,
    required this.type,
    this.isCountdown = true,
    this.isReverse = false,
  })  :
        // assert(!isCountdown || duration != null || isReverse),
        _currentTime = isCountdown ? duration : Duration(),
        restDuration = duration,
        reminders = [if (duration != null) Duration(seconds: duration.inSeconds ~/ 2)];

  final IntervalType type;
  final bool isCountdown;
  final bool isReverse;
  final List<Duration> reminders;

  DateTime? startTimeUtc;
  Duration? duration;
  Duration? restDuration;

  @observable
  Duration? _currentTime;

  @override
  Duration? get currentTime => _currentTime;

  @override
  IntervalInterface get currentInterval => this;

  @override
  IntervalInterface? get nextInterval => null;

  @override
  @computed
  Map<int, List<int>> get indexes {
    return {
      0: [1, 1]
    };
  }

  @override
  DateTime? get finishTimeUtc {
    if (startTimeUtc != null && restDuration != null) {
      return startTimeUtc!.add(restDuration!);
    }
    return null;
  }

  @override
  bool get isEnded => (isCountdown && currentTime == const Duration()) || (!isCountdown && currentTime == duration);

  @action
  void setDuration({Duration? newDuration}) {
    if (duration != null) return;
    if (newDuration != null) {
      duration = newDuration;
      restDuration = newDuration;
    } else {
      duration = _currentTime;
      restDuration = _currentTime;
    }
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
  }

  @override
  @action
  void tick(DateTime nowUtc) {
    if (isEnded) return;

    if (isCountdown) {
      _currentTime = finishTimeUtc!.difference(nowUtc);
    } else {
      final offset = (duration != null && restDuration != null) ? duration! - restDuration! : const Duration();
      _currentTime = offset + nowUtc.difference(startTimeUtc!);
    }
    print('#Interval# current time: $currentTime');
  }

  @override
  Interval copy() {
    return Interval(
      duration: duration,
      type: type,
      isCountdown: isCountdown,
      isReverse: isReverse,
    );
  }

  @override
  String description() {
    return 'Interval. Start: $startTimeUtc\nDuration: $duration\nFinish: $finishTimeUtc';
  }
}
