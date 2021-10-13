import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/round.dart';
import 'package:smart_timer/models/set.dart';
import 'package:smart_timer/models/workout.dart';
import 'package:smart_timer/stores/timer_status.dart';

part 'timer_store.g.dart';

class TimerState = TimerStateBase with _$TimerState;

abstract class TimerStateBase with Store {
  TimerStateBase(this.workout) : time = workout.sets[0].rounds[0].intervals[0].duration ?? const Duration(seconds: 0);

  final Workout workout;

  final _oneSecond = const Duration(seconds: 1);

  final stream = Stream.periodic(const Duration(seconds: 1), (x) => x);
  StreamSubscription? timerSubscription;

  @observable
  late Duration time;

  @observable
  var status = TimerStatus.stop;

  @observable
  var setIndex = 0;

  @observable
  var roundIndex = 0;

  @observable
  var intervalIndex = 0;

  @computed
  WorkoutSet get currentSet => workout.sets[setIndex];

  @computed
  int get setsCount => workout.sets.length;

  @computed
  Round get currentRound => currentSet.rounds[roundIndex];

  @computed
  int get roundsCount => currentSet.rounds.length;

  @computed
  Interval get currentInterval => currentRound.intervals[intervalIndex];

  @computed
  int get intervalsCount => currentRound.intervals.length;

  @computed
  IntervalType get currentType => currentInterval.type;

  @action
  void newTick() {
    if (currentInterval.isCountdown && time.inSeconds > 0) {
      time = time - _oneSecond;
    } else if (!currentInterval.isCountdown && (currentInterval.duration == null || time < currentInterval.duration!)) {
      time = time + _oneSecond;
    } else {
      if (intervalIndex < intervalsCount - 1) {
        intervalIndex++;
      } else if (roundIndex < roundsCount - 1) {
        roundIndex++;
        intervalIndex = 0;
      } else if (setIndex < setsCount - 1) {
        setIndex++;
        roundIndex = 0;
        intervalIndex = 0;
      } else {
        timerSubscription?.cancel();
        status = TimerStatus.done;
      }

      time = currentInterval.isCountdown ? currentInterval.duration! - _oneSecond : _oneSecond;
    }
  }

  @action
  void start() {
    timerSubscription?.cancel();
    time = currentInterval.isCountdown ? workout.sets[0].rounds[0].intervals[0].duration! : const Duration(seconds: 0);
    status = TimerStatus.run;
    roundIndex = 0;
    intervalIndex = 0;
    timerSubscription = stream.listen((_) {
      newTick();
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
