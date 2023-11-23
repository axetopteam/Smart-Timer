// ignore_for_file: avoid_print

import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/UI/history/history_state.dart';
import 'package:smart_timer/analytics/analytics_manager.dart';

import 'package:smart_timer/sdk/sdk_service.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/services/audio_service.dart';
import 'package:smart_timer/services/timer_couter_service.dart';
import 'package:smart_timer/utils/datetime_extension.dart';

import '../timer_types/timer_settings_interface.dart';

part 'timer_state.g.dart';

class TimerState = TimerStateBase with _$TimerState;

abstract class TimerStateBase with Store {
  TimerStateBase({required TimerSettingsInterface timerSettings})
      : _workout = timerSettings.workout,
        timerType = timerSettings.type,
        settings = timerSettings.settings,
        status = ReadyStatus() {
    initialize();
  }
  final TimerType timerType;
  final WorkoutSettings settings;
  late final AudioService _audio;
  final _appProperties = AppProperties();

  Workout _workout;

  @observable
  TimerStatus status;

  @observable
  Duration? totalRestTime;

  bool _isSaved = false;

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

  DateTime get roundedNow => DateTime.now().toUtc().roundToSeconds();

  @action
  void start() {
    print('#TimerState# start timer');
    AnalyticsManager.eventTimerStarted.setProperty('timerType', timerType.name).commit();

    _workout = _workout.copyWith(startTime: roundedNow);
    timerSubscription = timeStream.listen((nowUtc) {
      tick(nowUtc);
    });
  }

  @action
  void pause() {
    print('#TimerState# pause timer');
    final currentStatus = status;
    if (currentStatus is RunStatus) {
      timerSubscription?.pause();
      _workout = _workout.startPause(roundedNow);
      _audio.pauseIfNeeded();
      status = PauseStatus(time: currentStatus.time, type: currentStatus.type);

      if (!_workout.isCountdownCompleted(now: roundedNow)) {
        print('#TimerState# reser timer');
        _workout = _workout.reset();
        status = ReadyStatus();
      }
      AnalyticsManager.eventTimerPaused.commit();
    }
  }

  @action
  void resume() {
    print('#TimerState# resume timer');

    _audio.resumeIfNeeded();
    _workout = _workout.endPause(roundedNow);

    timerSubscription?.resume();
    AnalyticsManager.eventTimerResumed.commit();
  }

  void completeCurrentInterval() {
    tick(
      roundedNow,
      completeCurrentInterval: true,
    );
    _audio.stop();
    AnalyticsManager.eventTimerRoundCompleted.commit();
  }

  @action
  void tick(DateTime nowUtc, {bool completeCurrentInterval = false}) {
    if (_workout.startTime == null) return;
    print('#TIMERSTATE# tick start');
    status = WorkoutCalculator.currentIntervalInfo(
      now: nowUtc,
      workout: _workout,
      completeCurrentInterval: completeCurrentInterval,
    );
    print('#TIMERSTATE# tick end');
    // final finishTimeUtc = workout.intervals.last.;
    // totalRestTime = finishTimeUtc?.difference(nowUtc);
    // print('#TIMER# $time, $currentIntervalDurationInMilliseconds, $partOfDuration');

    _playAudioIfNeeded(status);

    if (status is DoneStatus) {
      timerSubscription?.cancel();
      TimerCouterService().addNewTime(DateTime.now());
      _workout = _workout.setEndTime(nowUtc);
      _saveWorkout();

      AnalyticsManager.eventTimerFinished
          .setProperty('today_completed_timers_count', TimerCouterService().todaysCount)
          .setProperty('timer_type', timerType.name)
          .commit();
    }
  }

  Future<void> _saveWorkout() async {
    final startTime = _workout.startTime;
    final endTime = _workout.endTime;

    if (!_isSaved && startTime != null && endTime != null && _workout.isCountdownCompleted(now: endTime)) {
      _isSaved = true;
      await GetIt.I<HistoryState>().saveTraining(
        startAt: startTime,
        endAt: endTime,
        name: '',
        description: '',
        workoutSettings: settings,
        timerType: timerType,
        intervals: _workout.intervals,
        pauses: _workout.pauses,
      );
    }
  }

  @action
  void close() {
    _workout = _workout.setEndTime(roundedNow);
    _saveWorkout();
    timerSubscription?.cancel();
    _audio.stop();
    _audio.dispose();
  }

  //sound
  void _playAudioIfNeeded(TimerStatus status) {
    if (status is! RunStatus) return;
    {
      switch (status.soundType) {
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
