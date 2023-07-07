import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/workout_interval.dart';
import 'package:smart_timer/models/workout_interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';
import 'package:smart_timer/services/audio_service.dart';
import 'package:smart_timer/timer/timer_type.dart';
import 'package:smart_timer/utils/datetime_extension.dart';

import 'timer_status.dart';

part 'timer_state.g.dart';

class TimerState = TimerStateBase with _$TimerState;

abstract class TimerStateBase with Store {
  TimerStateBase({
    required this.workout,
    required this.timerType,
  });

  final WorkoutSet workout;
  final TimerType timerType;

  final countdownInterval = WorkoutInterval(
    type: WorkoutIntervalType.countdown,
    duration: const Duration(seconds: 5),
  );

  final timeStream = Stream.periodic(
    const Duration(milliseconds: 100),
    (x) {
      final roundedNow = DateTime.now().toUtc().roundToSeconds();
      return roundedNow;
    },
  ).asBroadcastStream();

  StreamSubscription? timerSubscription;

  @observable
  var currentState = TimerStatus.ready;

  @computed
  WorkoutInterval get currentInterval => !countdownInterval.isEnded ? countdownInterval : workout.currentInterval;

  Map<DateTime, SoundType> get reminders {
    return workout.reminders..addAll(!countdownInterval.isEnded ? countdownInterval.reminders : {});
  }

  @action
  void start() {
    final DateTime roundedNow = DateTime.now().toUtc().roundToSeconds();

    currentState = TimerStatus.run;
    countdownInterval.start(roundedNow);
    workout.start(countdownInterval.finishTimeUtc!);

    timerSubscription = timeStream.listen((nowUtc) {
      tick(nowUtc);
    });
  }

  @computed
  Duration? get currentTime {
    if (!countdownInterval.isEnded) {
      return countdownInterval.currentTime;
    } else {
      return workout.currentTime;
    }
  }

  @action
  void pause() {
    timerSubscription?.pause();
    workout.pause();
    if (!countdownInterval.isEnded) {
      countdownInterval.reset();
      currentState = TimerStatus.ready;
    } else {
      currentState = TimerStatus.pause;
    }
  }

  @action
  void resume() {
    final DateTime roundedNow = DateTime.now().toUtc().roundToSeconds();

    if (!countdownInterval.isEnded) {
      countdownInterval.start(roundedNow);
      workout.start(countdownInterval.finishTimeUtc!);
    } else {
      workout.start(roundedNow);
    }

    currentState = TimerStatus.run;
    timerSubscription?.resume();
  }

  @action
  void tick(DateTime nowUtc) {
    if (!countdownInterval.isEnded) {
      countdownInterval.tick(nowUtc);
    } else {
      workout.tick(nowUtc);

      if (workout.isEnded) {
        currentState = TimerStatus.done;
        close();
      }
    }
  }

  @action
  void close() {
    timerSubscription?.cancel();
  }
}
