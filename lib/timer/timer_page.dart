import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/analytics/analytics_manager.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/models/workout_interval_type.dart';
import 'package:smart_timer/services/app_review_service.dart';
import 'package:smart_timer/timer/timer_state.dart';
import 'package:smart_timer/timer/widgets/complete_button.dart';
import 'package:smart_timer/timer/widgets/digits_text.dart';
import 'package:smart_timer/utils/interable_extension.dart';
import 'package:smart_timer/utils/string_utils.dart';
import 'package:smart_timer/widgets/play_icon.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'timer_progress_container.dart';
import 'timer_status.dart';

@RoutePage()
class TimerPage extends StatefulWidget {
  const TimerPage(this.state, {Key? key}) : super(key: key);
  final TimerState state;

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with SingleTickerProviderStateMixin {
  StreamSubscription? timerSubscription;

  TimerState get state => widget.state;

  late final AnimationController controller;

  late final ReactionDisposer timeReactionDisposer;
  late final ReactionDisposer intervalReactionDisposer;

  var runAnimation = true;
  final curve = Curves.linear;

  @override
  void initState() {
    AnalyticsManager.eventTimerOpened.setProperty('timer_type', state.timerType.name).commit();
    WakelockPlus.enable();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 100),
      reverseDuration: const Duration(microseconds: 300),
    );

    timeReactionDisposer = reaction(
      (p0) => state.currentInterval.currentTime,
      (p0) {
        final currentIntervalDurationinMilliseconds = state.currentInterval.duration?.inMilliseconds;
        final partOfDuration = currentIntervalDurationinMilliseconds != null
            ? (currentIntervalDurationinMilliseconds - (state.currentTime?.inMilliseconds ?? 0)) /
                currentIntervalDurationinMilliseconds
            : 0.0;
        if (runAnimation && currentIntervalDurationinMilliseconds != null) {
          controller.animateTo(partOfDuration, duration: const Duration(milliseconds: 100));
        }
      },
    );

    intervalReactionDisposer = reaction(
      (p0) => state.currentInterval,
      (p0) {
        runAnimation = false;
        controller.animateTo(0, duration: const Duration(milliseconds: 500));
        Future.delayed(const Duration(milliseconds: 500), () => runAnimation = true);
      },
    );

    super.initState();
  }

  @override
  void dispose() async {
    timerSubscription?.cancel();
    WakelockPlus.disable();
    AnalyticsManager.eventTimerClosed
        .setProperty('status', state.currentState.name)
        .setProperty('timer_type', state.timerType.name)
        .commit();

    timeReactionDisposer();
    intervalReactionDisposer();
    controller.dispose();

    state.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (state.currentState != TimerStatus.ready && state.currentState != TimerStatus.done) {
          final res = await _showConfirmExitAlert();
          return res ?? false;
        }
        if (state.currentState == TimerStatus.done) {
          _requestAppReview();
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(state.timerType.readbleName),
          centerTitle: true,
          actions: [
            Observer(builder: (context) {
              return IconButton(
                onPressed: state.switchSoundOnOff,
                icon: state.soundOn
                    ? const Icon(CupertinoIcons.speaker_3_fill)
                    : const Icon(CupertinoIcons.speaker_slash_fill),
              );
            })
          ],
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
            final currentTime = state.currentTime;
            return GestureDetector(
              onTap: () {
                switch (state.currentState) {
                  case TimerStatus.ready:
                    state.start();
                    break;
                  case TimerStatus.run:
                    state.pause();
                    break;
                  case TimerStatus.pause:
                    state.resume();
                    break;
                  case TimerStatus.done:
                    break;
                }
              },
              child: TimerProgressContainer(
                color: state.timerType.workoutColor(context),
                timerStatus: state.currentState,
                controller: controller,
                // partOfHeight: currentIntervalDurationInSeconds != null
                //     ? (currentIntervalDurationInSeconds - (currentTime?.inMilliseconds ?? 0)) /
                //         currentIntervalDurationInSeconds
                //     : 0,
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
                          _buildTime(currentTime),
                          const SizedBox(height: 10),
                          _buildRoudsInfo(),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _totalTime(),
                            !state.workout.currentInterval.isCountdown && state.countdownInterval.isEnded
                                ? CompleteButton(
                                    action: state.endCurrentInterval,
                                    iconColor: state.timerType.workoutColor(context),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
        Expanded(flex: 2, child: _bottomClickableText()),
      ],
    );
  }

  Widget _bottomClickableText() {
    return Observer(builder: (context) {
      switch (state.currentState) {
        case TimerStatus.run:
          return TextButton(
            onPressed: () => state.pause(),
            child: Text(
              LocaleKeys.timer_pause.tr(),
              style: context.textTheme.bodyMedium,
            ),
          );
        case TimerStatus.pause:
          return TextButton(
            onPressed: () => state.resume(),
            child: Text(
              LocaleKeys.timer_resume.tr(),
              style: context.textTheme.bodyMedium,
            ),
          );
        case TimerStatus.done:
        case TimerStatus.ready:
          return const SizedBox();
      }
    });
  }

  Widget _buildTime(Duration? currentTime) {
    return SizedBox(
      height: PlayIcon.size,
      child: Observer(
        builder: (_) {
          final currentInterval = state.currentInterval;
          bool isFirstSecond = currentInterval.isFirstSecond;
          String text;
          if (currentInterval.type == WorkoutIntervalType.countdown) {
            if (state.currentState != TimerStatus.run) {
              return const PlayIcon();
            } else {
              text = currentTime != null ? currentTime.durationToString(isCountdown: true) : '– –';
            }
          } else {
            text = isFirstSecond
                ? currentInterval.type.redableName
                : currentTime != null
                    ? currentTime.durationToString(isCountdown: currentInterval.isCountdown)
                    : '– –';
          }
          final timeParts = text.split(':');

          if (timeParts.length != 2) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                text,
                style: context.textTheme.headlineSmall,
              ),
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: timeParts.map((e) => DigitsText(e)).addSeparator(
                  SizedBox(
                    width: 24,
                    child: Text(
                      ':',
                      style: context.textTheme.headlineSmall,
                    ),
                  ),
                ),
          );
        },
      ),
    );
  }

  Widget _totalTime() {
    if (state.timerType.showTotalTime && state.totalRestTime != null) {
      return Observer(builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${LocaleKeys.timer_total_time.tr()}: ${state.totalRestTime!.durationToString(isCountdown: true)}',
            style: context.textTheme.titleMedium,
          ),
        );
      });
    } else {
      return const SizedBox();
    }
  }

  Widget _buildRoudsInfo() {
    return Observer(builder: (_) {
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
        const Spacer(),
        Container(
          height: 180,
          width: 180,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: state.timerType.workoutColor(context),
            shape: BoxShape.circle,
          ),
          child: Icon(
            CupertinoIcons.checkmark_alt,
            size: 140,
            color: context.color.mainText,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          LocaleKeys.timer_completed_title.tr(),
          textAlign: TextAlign.center,
          style: context.textTheme.displayLarge,
        ),
        const SizedBox(height: 40),
        const Spacer(),
        ElevatedButtonTheme(
          data: context.buttonThemes.popupButtonTheme,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              _requestAppReview();
            },
            child: Text(LocaleKeys.timer_completed_button.tr()),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _requestAppReview() {
    Future.delayed(const Duration(seconds: 1), AppReviewService().requestReviewIfAvailable);
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

extension on Duration {
  String durationToString({bool isCountdown = false}) {
    if (inMicroseconds < 0) {
      return "-${(-this).durationToString}";
    }
    String twoDigitMinutes = twoDigits(inMinutes);
    final seconds = isCountdown ? isSecondsCeil : inSeconds;

    String twoDigitSeconds = twoDigits(seconds.remainder(secondsPerMinute));

    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
