import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/round.dart';
import 'package:smart_timer/models/workout.dart';
import 'package:smart_timer/stores/timer_status.dart';

part 'timer_store.g.dart';

class TimerState = TimerStateBase with _$TimerState;

abstract class TimerStateBase with Store {
  TimerStateBase(this.workout) : time = workout.rounds[0].intervals[0].duration ?? const Duration(seconds: 0);

  final Workout workout;

  final stream = Stream.periodic(const Duration(seconds: 1), (x) => x);
  StreamSubscription? timerSubscription;

  @observable
  late Duration time;

  @observable
  var status = TimerStatus.stop;

  @observable
  var roundIndex = 0;

  @observable
  var intervalIndex = 0;

  @computed
  Round get currentRound => workout.rounds[roundIndex];

  @computed
  Interval get currentInterval => workout.rounds[roundIndex].intervals[intervalIndex];

  int get roundsCount => workout.roundsCound;

  @computed
  IntervalType get currentType => workout.rounds[roundIndex].intervals[intervalIndex].type;

  @computed
  int get roundNumber {
    return roundIndex == 0 ? 1 : roundIndex;
  }

  @action
  void tick() {
    //TODO: нужен рефакторинг
    if (currentInterval.isCountdown) {
      if (time.inSeconds > 0) {
        time = time - const Duration(seconds: 1);
      } else {
        const oneSecond = Duration(seconds: 1);

        if (intervalIndex < currentRound.intervals.length - 1) {
          intervalIndex++;
          time = currentInterval.isCountdown ? workout.rounds[roundIndex].intervals[intervalIndex].duration! - oneSecond : oneSecond;
        } else {
          if (roundIndex < roundsCount) {
            roundIndex++;
            intervalIndex = 0;
            time = currentInterval.isCountdown ? workout.rounds[roundIndex].intervals[intervalIndex].duration! - oneSecond : oneSecond;
          } else {
            timerSubscription?.cancel();
            status = TimerStatus.done;
          }
        }
      }
    } else {
      final duration = currentInterval.duration;
      if (duration == null || time.inSeconds < duration.inSeconds) {
        time = time + const Duration(seconds: 1);
      } else {
        if (roundIndex < roundsCount) {
          roundIndex++;
          intervalIndex = 0;
          const oneSecond = Duration(seconds: 1);

          time = currentInterval.isCountdown ? workout.rounds[roundIndex].intervals[intervalIndex].duration! - oneSecond : oneSecond;
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
    time = currentInterval.isCountdown ? workout.rounds[0].intervals[0].duration! : const Duration(seconds: 0);
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

  @action
  void close() {
    timerSubscription?.cancel();
  }
}
