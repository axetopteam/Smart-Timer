import 'package:mobx/mobx.dart';

import 'interval_type.dart';

part 'interval.g.dart';

class Interval = IntervalBase with _$Interval;

abstract class IntervalBase with Store {
  IntervalBase({
    required this.duration,
    required this.type,
    this.isCountdown = true,
  })  : assert(!isCountdown || duration != null),
        currentTime = duration,
        restDuration = duration,
        reminders = [if (duration != null) Duration(seconds: duration.inSeconds ~/ 2)];

  final Duration duration;
  final IntervalType type;
  final bool isCountdown;
  final List<Duration> reminders;

  DateTime? startTimeUtc;
  Duration restDuration;

  @observable
  Duration currentTime;

  DateTime? get finishTimeUtc {
    if (startTimeUtc != null) {
      return startTimeUtc!.add(restDuration);
    }
    return null;
  }

  bool get isEnded => (isCountdown && currentTime == const Duration()) || (!isCountdown && currentTime == duration);

  @action
  void start(DateTime nowUtc) {
    startTimeUtc = nowUtc;
  }

  @action
  void pause() {
    startTimeUtc = null;

    restDuration = isCountdown ? currentTime : duration - currentTime;
  }

  @action
  void tick(DateTime nowUtc) {
    if (isEnded) return;

    if (isCountdown) {
      currentTime = finishTimeUtc!.difference(nowUtc);
    } else {
      currentTime = nowUtc.difference(startTimeUtc!);
    }
    print('#Interval# current time: $currentTime');
  }

  Interval copy() {
    return Interval(duration: duration, type: type, isCountdown: isCountdown);
  }
}
