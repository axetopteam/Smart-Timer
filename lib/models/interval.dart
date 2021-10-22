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
        currentTime = duration ?? const Duration(),
        reminders = [if (duration != null) Duration(seconds: duration.inSeconds ~/ 2)];

  final Duration? duration;
  final IntervalType type;
  final bool isCountdown;
  final List<Duration> reminders;

  @observable
  Duration currentTime;

  @computed
  bool get isEnded {
    if (isCountdown) {
      return currentTime <= const Duration();
    } else {
      return duration != null ? currentTime >= const Duration() : false;
    }
  }

  @action
  void tick() {
    if (isEnded) return;
    currentTime = isCountdown ? currentTime - const Duration(seconds: 1) : currentTime + const Duration(seconds: 1);
  }

  // factory IntervalBase.copy() {
  //   return Interval(duration: this.duration, type: this.type, isCountdown: this.isCountdown);
  // }
}
