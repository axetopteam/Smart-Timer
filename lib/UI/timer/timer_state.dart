// ignore_for_file: avoid_print

import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:smart_timer/analytics/analytics_manager.dart';
import 'package:smart_timer/sdk/models/workout/workout.dart';

import 'package:smart_timer/sdk/sdk_service.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/services/audio_service.dart';
import 'package:smart_timer/services/timer_couter_service.dart';
import 'package:smart_timer/utils/datetime_extension.dart';

part 'timer_state.g.dart';

class TimerState = TimerStateBase with _$TimerState;

abstract class TimerStateBase with Store {
  TimerStateBase({
    required Workout workout,
    required this.timerType,
  }) : _workout = workout {
    initialize();
  }
  final TimerType timerType;
  late final AudioService _audio;
  final _appProperties = AppProperties();

  Workout _workout;

  @observable
  TimerStatus status = ReadyStatus();

  @observable
  Duration? totalRestTime;

  void initialize() {
    _audio = AudioService();
    final soundOn = _appProperties.soundOn;
    this.soundOn = soundOn;
    _audio.switchSoundOnOff(soundOn);
    _workout = _workout.addCountdown(Duration(seconds: _appProperties.countdownSeconds));
  }

  final timeStream = Stream.periodic(
    const Duration(milliseconds: 100),
    (x) {
      final roundedNow = DateTime.now().toUtc().roundToSeconds();
      return roundedNow;
    },
  ).asBroadcastStream();

  StreamSubscription? timerSubscription;

  Map<DateTime, SoundType> get reminders {
    return {};
    // return workout.reminders..addAll(!countdownInterval.isEnded ? countdownInterval.reminders : {});
  }

  @action
  void start() {
    print('#TimerState# start timer');
    AnalyticsManager.eventTimerStarted.setProperty('timerType', timerType.name).commit();
    final DateTime roundedNow = DateTime.now().toUtc().roundToSeconds();

    _workout = _workout.copyWith(startTime: roundedNow);
    timerSubscription = timeStream.listen((nowUtc) {
      _playAudioIfNeeded(nowUtc);
      tick(nowUtc);
    });
  }

  @action
  void pause() {
    print('#TimerState# pause timer');
    final currentStatus = status;
    if (currentStatus is RunStatus) {
      final roundedNow = DateTime.now().toUtc().roundToSeconds();
      timerSubscription?.pause();
      _workout = _workout.startPause(roundedNow);
      _audio.pauseIfNeeded();
      status = PauseStatus(time: currentStatus.time, type: currentStatus.type);

      if (!_workout.isCountdownCompleted(now: roundedNow)) {
        print('#TimerState# reser timer');
        _workout = _workout.reset();
        status = ReadyStatus();
      }
      //TODO: сброс таймера если не закончился обратный отсчет
      // if (!countdownInterval.isEnded) {
      //   countdownInterval.reset();
      //   currentState = TimerStatus.ready;
      // } else {
      //   currentState = TimerStatus.pause;
      // }
      AnalyticsManager.eventTimerPaused.commit();
    }
  }

  @action
  void resume() {
    print('#TimerState# resume timer');

    final DateTime roundedNow = DateTime.now().toUtc().roundToSeconds();
    _audio.resumeIfNeeded();
    _workout = _workout.endPause(roundedNow);
    // if (!countdownInterval.isEnded) {
    //   countdownInterval.start(roundedNow);
    //   workout.start(countdownInterval.finishTimeUtc!);
    // } else {
    //   workout.start(roundedNow);
    // }

    timerSubscription?.resume();
    AnalyticsManager.eventTimerResumed.commit();
  }

  void endCurrentInterval() {
    // workout.setDuration();
    AnalyticsManager.eventTimerRoundCompleted.commit();
  }

  @action
  void tick(DateTime nowUtc) {
    if (_workout.startTime == null) return;
    status = WorkoutCalculator.currentIntervalInfo(
        now: nowUtc, startTime: _workout.startTime!, intervals: _workout.intervals, pauses: _workout.pauses);
    // final finishTimeUtc = workout.intervals.last.;
    // totalRestTime = finishTimeUtc?.difference(nowUtc);
    // print('#TIMER# $time, $currentIntervalDurationInMilliseconds, $partOfDuration');

//
    if (status is DoneStatus) {
      timerSubscription?.cancel();
      TimerCouterService().addNewTime(DateTime.now());

      AnalyticsManager.eventTimerFinished
          .setProperty('today_completed_timers_count', TimerCouterService().todaysCount)
          .setProperty('timer_type', timerType.name)
          .commit();
    }
  }

  @action
  void close() {
    timerSubscription?.cancel();
    _audio.stop();
    _audio.dispose();
  }

  //sound
  void _playAudioIfNeeded(DateTime dateTime) {
    switch (reminders[dateTime]) {
      case SoundType.countdown:
        _audio.playCountdown();
        break;
      case SoundType.tenSeconds:
        _audio.play10Seconds();
        break;
      case SoundType.lastRound:
        _audio.playLastRound();
        break;
      case SoundType.halfTime:
        _audio.playHalfTime();
        break;
      case null:
        break;
    }
  }

  @observable
  bool soundOn = true;

  @action
  Future<void> switchSoundOnOff() async {
    try {
      soundOn = !soundOn;
      await _audio.switchSoundOnOff(soundOn);
      AppProperties().saveSoundOn(soundOn);
      AnalyticsManager.eventTimerSoundSwitched.setProperty('on', soundOn.toString()).commit();
    } catch (_) {}
  }
}
