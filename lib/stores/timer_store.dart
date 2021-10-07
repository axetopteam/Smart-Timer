import 'dart:async';
import 'dart:math';

import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/stores/timer_status.dart';

part 'timer_store.g.dart';

class TimerState = TimerStateBase with _$TimerState;

abstract class TimerStateBase with Store {
  TimerStateBase(this.timerSchedule) : restTime = timerSchedule[0].duration;

  final List<Interval> timerSchedule;

  final stream = Stream.periodic(const Duration(seconds: 1), (x) => x);
  StreamSubscription? timerSubscription;

  @observable
  late Duration restTime;

  @observable
  var status = TimerStatus.stop;

  @observable
  var intervalIndex = 0;

  @computed
  Interval get currentInterval => timerSchedule[intervalIndex];

  @computed
  int get currentRound => max(((intervalIndex + 1) ~/ 2), 1);

  int get rounds => (timerSchedule.length - 1) ~/ 2;

  @action
  void tick() {
    if (restTime.inSeconds > 0) {
      restTime = restTime - const Duration(seconds: 1);
    } else {
      if (intervalIndex < timerSchedule.length - 1) {
        intervalIndex++;
        restTime = timerSchedule[intervalIndex].duration;
      } else {
        timerSubscription?.cancel();
        status = TimerStatus.done;
      }
    }
  }

  @action
  void start() {
    timerSubscription?.cancel();
    restTime = timerSchedule[0].duration;
    status = TimerStatus.run;
    intervalIndex = 0;
    timerSubscription = stream.listen((_) {
      tick();
    });
  }

  @action
  void pause() {
    // timer?.cancel();
    timerSubscription?.pause();
    status = TimerStatus.pause;
  }

  @action
  void resume() {
    status = TimerStatus.run;
    timerSubscription?.resume();
  }
}
