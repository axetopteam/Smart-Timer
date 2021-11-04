import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';
import 'package:smart_timer/stores/timer_status.dart';
import 'package:smart_timer/utils/datetime_extension.dart';

part 'timer.g.dart';

class Timer = TimerBase with _$Timer;

abstract class TimerBase with Store {
  TimerBase(this.workout);

  final WorkoutSet workout;

  final countdownInterval = Interval(
    type: IntervalType.countdown,
    duration: const Duration(seconds: 4),
  );

  final stream = Stream.periodic(
    const Duration(milliseconds: 100),
    (x) {
      final roundedNow = DateTime.now().toUtc().roundToSeconds();
      return roundedNow;
    },
  );

  StreamSubscription? timerSubscription;

  @observable
  var status = TimerStatus.stop;

  @computed
  Interval get currentInterval => !countdownInterval.isEnded ? countdownInterval : workout.currentInterval;

  @computed
  String get indexes {
    StringBuffer buffer = StringBuffer();
    for (int i = workout.indexes.length - 1; i > 0; i--) {
      final index = workout.indexes.length - i;
      buffer.write('$index: ${workout.indexes[i]![0]}/${workout.indexes[i]![1]}\n');
    }
    return buffer.toString();
  }

  @action
  void start() {
    final DateTime roundedNow = DateTime.now().toUtc().roundToSeconds();

    status = TimerStatus.run;
    countdownInterval.start(roundedNow);
    workout.start(countdownInterval.finishTimeUtc!);

    timerSubscription = stream.listen((nowUtc) {
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
    if (!countdownInterval.isEnded) {
      countdownInterval.reset();
    }
    workout.pause();
    status = TimerStatus.pause;
  }

  @action
  void restart() {
    final DateTime roundedNow = DateTime.now().toUtc().roundToSeconds();

    if (!countdownInterval.isEnded) {
      countdownInterval.start(roundedNow);
      workout.start(countdownInterval.finishTimeUtc!);
    } else {
      workout.start(roundedNow);
    }

    status = TimerStatus.run;
    timerSubscription?.resume();
  }

  @action
  void tick(DateTime nowUtc) {
    if (!countdownInterval.isEnded) {
      countdownInterval.tick(nowUtc);
    } else {
      workout.tick(nowUtc);

      if (workout.isEnded) {
        status = TimerStatus.done;
        close();
      }
    }
  }

  @action
  void close() {
    timerSubscription?.cancel();
  }
}
