import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:smart_timer/analytics/analytics_manager.dart';
import 'package:smart_timer/models/workout_interval.dart';
import 'package:smart_timer/models/workout_interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/services/audio_service.dart';
import 'package:smart_timer/services/timer_couter_service.dart';
import 'package:smart_timer/timer/timer_type.dart';
import 'package:smart_timer/utils/datetime_extension.dart';

import 'timer_status.dart';

part 'timer_state.g.dart';

class TimerState = TimerStateBase with _$TimerState;

abstract class TimerStateBase with Store {
  TimerStateBase({
    required this.workout,
    required this.timerType,
  }) {
    initialize();
  }

  final WorkoutSet workout;
  final TimerType timerType;

  late final AudioService _audio;

  final _appProperties = AppProperties();

  void initialize() {
    _audio = AudioService();
    final soundOn = _appProperties.soundOn;
    this.soundOn = soundOn;
    _audio.switchSoundOnOff(soundOn);
    countdownInterval = WorkoutInterval(
      type: WorkoutIntervalType.countdown,
      duration: Duration(seconds: _appProperties.countdownSeconds) - const Duration(milliseconds: 1),
    );
  }

  late final WorkoutInterval countdownInterval;

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
    AnalyticsManager.eventTimerStarted.setProperty('timerType', timerType.name).commit();
    final DateTime roundedNow = DateTime.now().toUtc().roundToSeconds();

    currentState = TimerStatus.run;
    countdownInterval.start(roundedNow);
    workout.start(countdownInterval.finishTimeUtc!);

    timerSubscription = timeStream.listen((nowUtc) {
      _playAudioIfNeeded(nowUtc);
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

  @observable
  Duration? totalRestTime;

  @action
  void pause() {
    timerSubscription?.pause();
    workout.pause();
    _audio.pauseIfNeeded();
    if (!countdownInterval.isEnded) {
      countdownInterval.reset();
      currentState = TimerStatus.ready;
    } else {
      currentState = TimerStatus.pause;
    }
    AnalyticsManager.eventTimerPaused.commit();
  }

  @action
  void resume() {
    final DateTime roundedNow = DateTime.now().toUtc().roundToSeconds();
    _audio.resumeIfNeeded();
    if (!countdownInterval.isEnded) {
      countdownInterval.start(roundedNow);
      workout.start(countdownInterval.finishTimeUtc!);
    } else {
      workout.start(roundedNow);
    }

    currentState = TimerStatus.run;
    timerSubscription?.resume();
    AnalyticsManager.eventTimerResumed.commit();
  }

  void endCurrentInterval() {
    workout.setDuration();
    AnalyticsManager.eventTimerRoundCompleted.commit();
  }

  @action
  void tick(DateTime nowUtc) {
    if (!countdownInterval.isEnded) {
      countdownInterval.tick(nowUtc);
    } else {
      workout.tick(nowUtc);
      final finishTimeUtc = workout.finishTimeUtc;
      totalRestTime = finishTimeUtc?.difference(nowUtc);

      if (workout.isEnded) {
        currentState = TimerStatus.done;
        timerSubscription?.cancel();
        TimerCouterService().addNewTime(DateTime.now());
        AnalyticsManager.eventTimerFinished
            .setProperty('today_completed_timers_count', TimerCouterService().todaysCount)
            .setProperty('timer_type', timerType.name)
            .commit();
      }
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
