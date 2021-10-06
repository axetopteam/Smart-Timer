import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:smart_timer/application/models/interval.dart';
import 'package:smart_timer/stores/timer_status.dart';

part 'timer_store.g.dart';

class TimerState = TimerStateBase with _$TimerState;

abstract class TimerStateBase with Store {
  TimerStateBase(this.timerSchedule) : restTime = timerSchedule[0].duration;

  final List<Interval> timerSchedule;

  @observable
  late Duration restTime;

  @observable
  var status = TimerStatus.stop;

  Timer? timer;

  @observable
  var intervalIndex = 0;

  @computed
  Interval get currentInterval => timerSchedule[intervalIndex];

  @action
  void tick() {
    if (restTime.inSeconds > 0) {
      restTime = restTime - const Duration(seconds: 1);
    } else {
      if (intervalIndex < timerSchedule.length) {
        intervalIndex++;
        restTime = timerSchedule[intervalIndex].duration;
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
    restTime = timerSchedule[0].duration;
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
