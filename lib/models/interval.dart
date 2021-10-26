import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interfaces/interval_interface.dart';

import 'interval_type.dart';

part 'interval.g.dart';

class Interval = IntervalBase with _$Interval;

abstract class IntervalBase with Store implements IntervalInterface {
  IntervalBase({
    required this.duration,
    required this.type,
    this.isCountdown = true,
  })  : assert(!isCountdown || duration != null),
        _currentTime = duration,
        restDuration = duration,
        reminders = [if (duration != null) Duration(seconds: duration.inSeconds ~/ 2)];

  final Duration duration;
  final IntervalType type;
  final bool isCountdown;
  final List<Duration> reminders;

  DateTime? startTimeUtc;
  Duration restDuration;

  @observable
  Duration _currentTime;

  @override
  Duration get currentTime => _currentTime;

  @override
  @computed
  Map<int, List<int>> get indexes {
    return {
      0: [1, 1]
    };
  }

  @override
  DateTime? get finishTimeUtc {
    if (startTimeUtc != null) {
      return startTimeUtc!.add(restDuration);
    }
    return null;
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

    restDuration = isCountdown ? currentTime : duration - currentTime;
  }

  @override
  @action
  void tick(DateTime nowUtc) {
    if (isEnded) return;

    if (isCountdown) {
      _currentTime = finishTimeUtc!.difference(nowUtc);
    } else {
      _currentTime = nowUtc.difference(startTimeUtc!);
    }
    print('#Interval# current time: $currentTime');
  }

  Interval copy() {
    return Interval(duration: duration, type: type, isCountdown: isCountdown);
  }

  @override
  String description() {
    return 'Interval. Start: $startTimeUtc\nDuration: $duration\nFinish: $finishTimeUtc';
  }
}
