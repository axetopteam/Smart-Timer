import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/round.dart';
import 'package:smart_timer/models/workout.dart';
import 'package:smart_timer/stores/timer_status.dart';

part 'timer_store.g.dart';

class TimerState = TimerStateBase with _$TimerState;

abstract class TimerStateBase with Store {
  TimerStateBase(this.workout) : restTime = workout.rounds[0].intervals[0].duration;

  final Workout workout;

  final stream = Stream.periodic(const Duration(seconds: 1), (x) => x);
  StreamSubscription? timerSubscription;

  @observable
  late Duration restTime;

  @observable
  var status = TimerStatus.stop;

  @observable
  var roundIndex = 0;

  @observable
  var intervalIndex = 0;

  @computed
  Round get currentRound => workout.rounds[roundIndex];

  int get roundsCount => workout.roundsCound;

  @computed
  IntervalType get currentType => workout.rounds[roundIndex].intervals[intervalIndex].type;

  @computed
  int get roundNumber {
    return roundIndex == 0 ? 1 : roundIndex;
  }

  @action
  void tick() {
    if (restTime.inSeconds > 0) {
      restTime = restTime - const Duration(seconds: 1);
    } else {
      if (intervalIndex < currentRound.intervals.length - 1) {
        intervalIndex++;
        restTime = workout.rounds[roundIndex].intervals[intervalIndex].duration;
      } else {
        if (roundIndex < roundsCount - 1) {
          roundIndex++;
          intervalIndex = 0;
          restTime = workout.rounds[roundIndex].intervals[intervalIndex].duration;
        } else {
          timerSubscription?.cancel();
          status = TimerStatus.done;
        }
      }
    }
  }

  @action
  void start() {
    timerSubscription?.cancel();
    restTime = workout.rounds[0].intervals[0].duration;
    status = TimerStatus.run;
    roundIndex = 0;
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
