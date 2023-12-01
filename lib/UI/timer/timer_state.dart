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
        status = ReadyStatus(indexes: timerSettings.workout.firstIntervalIndexes) {
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
      status = PauseStatus(
        time: currentStatus.time,
        type: currentStatus.type,
        isReverse: currentStatus.isReverse,
        indexes: currentStatus.indexes,
      );

      if (!_workout.isCountdownCompleted(now: roundedNow)) {
        print('#TimerState# reser timer');
        _workout = _workout.reset();
        status = ReadyStatus(indexes: _workout.firstIntervalIndexes);
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

  Interval? getNextInterval(int index) => index + 1 < _workout.intervals.length ? _workout.intervals[index + 1] : null;

  void completeCurrentInterval() {
    final now = roundedNow;
    final (_, pastTime, currentIndex) = WorkoutCalculator.currentIntervalInfo(now: now, workout: _workout);
    final currentInterval = _workout.intervals[currentIndex];
    final nextInterval = getNextInterval(currentIndex);

    final completedInterval = FiniteInterval(
      duration: pastTime!,
      isReverse: false,
      activityType: currentInterval.activityType,
      isLast: currentInterval.isLast,
      indexes: currentInterval.indexes,
    );
    final newIntervals = List.of(_workout.intervals);
    newIntervals[currentIndex] = completedInterval;

    if (nextInterval != null && nextInterval is RatioInterval) {
      final newNext = FiniteInterval(
        duration: pastTime * nextInterval.ratio,
        isReverse: true,
        activityType: nextInterval.activityType,
        indexes: nextInterval.indexes,
        isLast: nextInterval.isLast,
      );
      newIntervals[currentIndex + 1] = newNext;
    } else if (nextInterval != null && nextInterval is RepeatLastInterval) {
      newIntervals.removeAt(currentIndex + 1);
    }

    _workout = _workout.copyWith(intervals: newIntervals);

    tick(now);
    _audio.stop();
    AnalyticsManager.eventTimerRoundCompleted.commit();
  }

  @action
  void tick(DateTime nowUtc) {
    if (_workout.startTime == null) return;
    final (curentTime, _, currentIndex) = WorkoutCalculator.currentIntervalInfo(
      now: nowUtc,
      workout: _workout,
    );
    if (currentIndex < 0) {
      status = ReadyStatus(indexes: _workout.firstIntervalIndexes);
      return;
    }
    if (currentIndex >= _workout.intervals.length) {
      _timerCompleted(nowUtc).then((value) => status = value);
      return;
    }

    final currentInterval = _workout.intervals[currentIndex];

    if (currentIndex > 0 && currentInterval is RepeatLastInterval) {
      _insertNewInterval(currentIndex);
      tick(nowUtc);
      return;
    }

    if (curentTime != null) {
      status = RunStatus(
        time: curentTime,
        type: currentInterval.activityType,
        indexes: currentInterval.indexes,
        canBeCompleted: WorkoutCalculator.checkCanBeCompleted(currentInterval),
        soundType: WorkoutCalculator.checkSound(currentInterval, curentTime),
        isReverse: currentInterval is FiniteInterval && currentInterval.isReverse,
      );
    }
    _playAudioIfNeeded(status);
  }

  void _insertNewInterval(int index) {
    final previousInterval = _workout.intervals[index - 1];
    final previousIntervalIndexes = List.of(previousInterval.indexes);
    previousIntervalIndexes.last = previousIntervalIndexes.last.copyWith(previousIntervalIndexes.last.index + 1);

    _workout = _workout.copyWith(
      intervals: List.of(_workout.intervals)
        ..insert(
          index,
          previousInterval.copyWith(indexes: previousIntervalIndexes),
        ),
    );
  }

  Future<DoneStatus> _timerCompleted(DateTime time) async {
    timerSubscription?.cancel();
    TimerCouterService().addNewTime(DateTime.now());
    _workout = _workout.setEndTime(time);
    final result = await _saveWorkout();

    AnalyticsManager.eventTimerFinished
        .setProperty('today_completed_timers_count', TimerCouterService().todaysCount)
        .setProperty('timer_type', timerType.name)
        .commit();
    return DoneStatus(result: result);
  }

  Future<TrainingHistoryRecord?> _saveWorkout() async {
    final startTime = _workout.startTime;
    final endTime = _workout.endTime;

    if (!_isSaved && startTime != null && endTime != null && _workout.isCountdownCompleted(now: endTime)) {
      _isSaved = true;
      final record = await GetIt.I<HistoryState>().saveTraining(
        startAt: startTime,
        endAt: endTime,
        name: '',
        description: '',
        workoutSettings: settings,
        timerType: timerType,
        intervals: _workout.intervals,
        pauses: _workout.pauses,
      );
      return record;
    }
    return null;
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
