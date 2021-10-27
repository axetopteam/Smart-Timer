import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/round.dart';
import 'package:smart_timer/stores/timer_status.dart';
import 'package:smart_timer/utils/datetime_extension.dart';

part 'timer.g.dart';

class Timer = TimerBase with _$Timer;

abstract class TimerBase with Store {
  TimerBase(this.workout);

  final Round workout;

  final stream = Stream.periodic(
    const Duration(milliseconds: 1000),
    (x) {
      final roundedNow = DateTime.now().toUtc().roundToSeconds();
      // print('#TIMER# stream roundedNow: $roundedNow');
      return roundedNow;
    },
  );

  StreamSubscription? timerSubscription;

  @observable
  var status = TimerStatus.stop;

  @action
  void tick(DateTime nowUtc) {
    workout.tick(nowUtc);

    if (workout.isEnded) {
      status = TimerStatus.done;
      close();
    }
  }

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
    workout.start(roundedNow);

    timerSubscription = stream.listen((nowUtc) {
      tick(nowUtc);
    });
  }

  @action
  void restart() {
    final DateTime roundedNow = DateTime.now().toUtc().roundToSeconds();

    workout.start(roundedNow);
    status = TimerStatus.run;
    timerSubscription?.resume();
  }

  @action
  void pause() {
    timerSubscription?.pause();
    workout.pause();
    status = TimerStatus.pause;
  }

  @action
  void close() {
    timerSubscription?.cancel();
  }
}
