import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/models/workout_interval_type.dart';
import 'package:smart_timer/services/audio_service.dart';
import 'package:smart_timer/timer/timer_state.dart';
import 'package:smart_timer/utils/string_utils.dart';
import 'package:smart_timer/widgets/play_icon.dart';
import 'package:wakelock/wakelock.dart';

import 'timer_progress_container.dart';
import 'timer_status.dart';

class TimerPage extends StatefulWidget {
  const TimerPage(this.state, {Key? key}) : super(key: key);
  final TimerState state;

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  AudioService audio = AudioService();

  // AudioPlayer audioPlayer = AudioPlayer();
  // late final ReactionDisposer reactionDispose;

  StreamSubscription? timerSubscription;

  TimerState get state => widget.state;

  @override
  void initState() {
    Wakelock.enable();
    // audio.initialize();

    timerSubscription = state.timeStream.listen(
      (now) {
        if (state.reminders.containsKey(now)) {
          switch (state.reminders[now]) {
            case SoundType.countdown:
              audio.playCountdown();
              break;
            case SoundType.tenSeconds:
              audio.play10Seconds();
              break;
            case SoundType.lastRound:
              audio.playLastRound();
              break;
            case SoundType.halfTime:
              audio.playHalfTime();
              break;
            case null:
              break;
          }
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() async {
    timerSubscription?.cancel();
    Wakelock.disable();
    audio.stop();
    audio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (state.currentState != TimerStatus.ready) {
          final res = await _showConfirmExitAlert();
          return res ?? false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(state.timerType.readbleName),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Observer(
                builder: (ctx) => state.currentState == TimerStatus.done ? _buildFinish() : _buildTimerContainer(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildTimerContainer() {
    return Column(
      children: [
        const Spacer(flex: 1),
        Expanded(
          flex: 12,
          child: Observer(builder: (context) {
            final currentInterval = state.currentInterval;
            final currentTime = state.currentTime;
            final currentIntervalDurationInSeconds = currentInterval.duration?.inSeconds;
            return GestureDetector(
              onTap: () {
                switch (state.currentState) {
                  case TimerStatus.ready:
                    state.start();
                    break;
                  case TimerStatus.run:
                    state.pause();
                    audio.pauseIfNeeded();
                    break;
                  case TimerStatus.pause:
                    state.resume();
                    audio.resumeIfNeeded();
                    break;
                  case TimerStatus.done:
                    break;
                }
              },
              child: TimerProgressContainer(
                color: state.timerType.workoutColor(context),
                timerStatus: state.currentState,
                partOfHeight: currentIntervalDurationInSeconds != null
                    ? (currentIntervalDurationInSeconds - (currentTime?.inSeconds ?? 0)) /
                        currentIntervalDurationInSeconds
                    : 0,
                child: SizedBox.expand(
                  child: Column(
                    children: [
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Observer(builder: (_) {
                            final currentInterval = state.currentInterval;
                            return Text(
                              currentInterval.type.redableName,
                              style: context.textTheme.titleSmall,
                            );
                          }),
                          const SizedBox(height: 10),
                          Observer(builder: (_) {
                            final currentInterval = state.currentInterval;
                            bool isFirstSecond = currentInterval.isFirstSecond;
                            if (currentInterval.type == WorkoutIntervalType.countdown) {
                              if (isFirstSecond && state.currentState != TimerStatus.run) {
                                return const PlayIcon();
                              } else {
                                return Text(
                                  state.currentTime != null
                                      ? durationToString2(
                                          state.currentTime!,
                                          isCountdown: currentInterval.isCountdown,
                                        )
                                      : '--',
                                  style: context.textTheme.headlineSmall,
                                );
                              }
                            }
                            final text = isFirstSecond
                                ? currentInterval.type.redableName
                                : state.currentTime != null
                                    ? durationToString2(
                                        state.currentTime!,
                                        isCountdown: currentInterval.isCountdown,
                                      )
                                    : '--';
                            return Text(
                              text,
                              style: context.textTheme.headlineSmall,
                            );
                          }),
                          const SizedBox(height: 10),
                          _buildRoudsInfo(),
                        ],
                      ),
                      Expanded(
                        child: !state.workout.currentInterval.isCountdown && state.countdownInterval.isEnded
                            ? GestureDetector(
                                onHorizontalDragEnd: (details) {
                                  state.workout.setDuration();
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.swipe_right, size: 30),
                                      const SizedBox(width: 12),
                                      Text(
                                        LocaleKeys.timer_complete_round.tr(),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: Observer(builder: (context) {
              switch (state.currentState) {
                case TimerStatus.run:
                  return Text(LocaleKeys.timer_pause.tr());
                case TimerStatus.pause:
                  return Text(LocaleKeys.timer_resume.tr());
                case TimerStatus.done:
                case TimerStatus.ready:
                  return Container();
              }
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildRoudsInfo() {
    return Observer(builder: (_) {
      if (!state.countdownInterval.isEnded) {
        return const SizedBox();
      }
      return Text(
        state.workout.currentStateDescription ?? '',
        style: context.textTheme.displayMedium,
        textAlign: TextAlign.center,
      );
    });
  }

  Widget _buildFinish() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 160,
          width: 160,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: state.timerType.workoutColor(context),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            CupertinoIcons.check_mark,
            size: 120,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          'Well Done',
          textAlign: TextAlign.center,
          style: context.textTheme.displayLarge,
        ),

        //TODO: нужна кнопка завершить
      ],
    );
  }

  Future<bool?> _showConfirmExitAlert() {
    return showCupertinoDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (ctx) {
          return CupertinoAlertDialog(
            title: Text(LocaleKeys.timer_confirm_exit_alert_title.tr()),
            content: Text(LocaleKeys.timer_confirm_exit_alert_content.tr()),
            actions: [
              CupertinoDialogAction(
                child: Text(LocaleKeys.cancel.tr()),
                onPressed: () => Navigator.of(ctx).pop(false),
              ),
              CupertinoDialogAction(
                child: Text(LocaleKeys.yes.tr()),
                onPressed: () => Navigator.of(ctx).pop(true),
              ),
            ],
          );
        });
  }
}
