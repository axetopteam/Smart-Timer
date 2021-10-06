import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:smart_timer/stores/timer_status.dart';

part 'timer_store.g.dart';

class TimerState = TimerStateBase with _$TimerState;

abstract class TimerStateBase with Store {
  TimerStateBase(List<Duration> timerSchedule)
      : _timerSchedule = [
          const Duration(seconds: 10),
          ...timerSchedule,
        ],
        restTime = const Duration(seconds: 10);

  @observable
  late Duration restTime;

  final List<Duration> _timerSchedule;

  @observable
  var status = TimerStatus.ready;

  Timer? timer;

  @observable
  var intervalIndex = 0;

  @action
  void tick() {
    if (restTime.inSeconds > 0) {
      restTime = restTime - const Duration(seconds: 1);
    } else {
      if (intervalIndex < _timerSchedule.length) {
        intervalIndex++;
        restTime = _timerSchedule[intervalIndex];
      } else {
        timer?.cancel();
        status = TimerStatus.done;
      }
    }
  }

  @action
  void start() {
    // time = initialTime;
    timer?.cancel();
    restTime = _timerSchedule[0];
    status = TimerStatus.run;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      tick();
    });
  }

  @action
  void pause() {
    timer?.cancel();
    status = TimerStatus.pause;
  }

  @action
  void restart() {
    status = TimerStatus.run;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      tick();
    });
  }
}
