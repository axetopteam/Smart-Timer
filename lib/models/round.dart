import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:smart_timer/stores/timer_status.dart';
import 'package:smart_timer/utils/datetime_extension.dart';
import 'interval.dart';

part 'round.g.dart';

class Round = RoundBase with _$Round;

abstract class RoundBase with Store {
  RoundBase(this.intervals);

  final List<Interval> intervals;

  final stream = Stream.periodic(
    const Duration(seconds: 1),
    (x) {
      final roundedNow = DateTime.now().toUtc().roundToSeconds();
      return roundedNow;
    },
  ).asBroadcastStream();

  StreamSubscription? timerSubscription;

  @observable
  var status = TimerStatus.stop;

  //interval info
  @observable
  int _intervalIndex = 0;

  @computed
  int get intervalIndex => _intervalIndex;

  @computed
  int get intervalsCount => intervals.length;
  //

  Interval get _currentInterval => intervals[_intervalIndex];

  bool isEnded(DateTime nowUtc) => intervals.last.isEnded;

  @computed
  Duration get currentTime => _currentInterval.currentTime;

  @action
  void tick(DateTime nowUtc) {
    if (isEnded(nowUtc)) {
      status = TimerStatus.done;
      close();
    }

    for (int i = _intervalIndex; i < intervalsCount - 1; i++) {
      if (!_currentInterval.isEnded) {
        break;
      }
      _intervalIndex++;
    }

    // while (_currentInterval.isEnded(nowUtc)) {
    //   _intervalIndex++;
    // }
    // if (_currentInterval.isEnded(nowUtc)) {
    //   _intervalIndex++;
    //   // print('#ROUND# interval index: $_intervalIndex');
    //   // _currentInterval.start(nowUtc);

    // }

    _currentInterval.tick(nowUtc);
  }

  @action
  void start() {
    timerSubscription?.cancel();
    status = TimerStatus.run;

    setStartTimes();

    timerSubscription = stream.listen((nowUtc) {
      tick(nowUtc);
    });
  }

  void setStartTimes() {
    final roundedNow = DateTime.now().toUtc().roundToSeconds();

    intervals[0].start(roundedNow);

    if (intervalsCount > 1) {
      for (int i = 1; i < intervalsCount; i++) {
        intervals[i].start((intervals[i - 1].finishTimeUtc!));
      }
    }
    // intervals.forEach((element) {
    //   print('start time: ${element.startTimeUtc}');
    //   print('rest duration: ${element.restDuration}');
    // });
  }

  // @action
  // void resume() {
  //   timerSubscription?.pause();

  //   final roundedNow = DateTime.now().toUtc().roundToSeconds();
  //   intervals.forEach((interval) => interval.pause(roundedNow));

  //   status = TimerStatus.pause;
  // }

  @action
  void pause() {
    timerSubscription?.pause();

    intervals.forEach((interval) => interval.pause());

    status = TimerStatus.pause;
  }

  @action
  void close() {
    timerSubscription?.cancel();
  }
}
