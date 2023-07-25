import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_timer/analytics/analytics_manager.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/models/workout_interval_type.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/services/app_review_service.dart';
import 'package:smart_timer/services/audio_service.dart';
import 'package:smart_timer/timer/timer_state.dart';
import 'package:smart_timer/utils/interable_extension.dart';
import 'package:smart_timer/utils/string_utils.dart';
import 'package:smart_timer/widgets/play_icon.dart';
import 'package:smart_timer/widgets/swipe_button/slider_button.dart';
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

class _TimerPageState extends State<TimerPage> {
  StreamSubscription? timerSubscription;

  TimerState get state => widget.state;

  @override
  void initState() {
    AnalyticsManager.eventTimerOpened;
    WakelockPlus.enable();

    state.initializeAudio(AppProperties().soundOn);

    timerSubscription = state.timeStream.listen(
      (now) {
        if (state.reminders.containsKey(now)) {
          switch (state.reminders[now]) {
            case SoundType.countdown:
              state.playCountdown();
              break;
            case SoundType.tenSeconds:
              state.play10Seconds();
              break;
            case SoundType.lastRound:
              state.playLastRound();
              break;
            case SoundType.halfTime:
              state.playHalfTime();
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
    WakelockPlus.disable();
    AnalyticsManager.eventTimerClosed.setProperty('status', state.currentState.name);

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
                          _buildTime(),
                          const SizedBox(height: 10),
                          _buildRoudsInfo(),
                        ],
                      ),
                      Expanded(
                        child: !state.workout.currentInterval.isCountdown && state.countdownInterval.isEnded
                            ? _buildCompleteRoundButton()
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
                  return Container();
              }
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildCompleteRoundButton() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SliderButton(
        backgroundColor: Colors.white30,
        label: Text(
          LocaleKeys.timer_complete_round.tr(),
          style: context.textTheme.bodyLarge,
        ),
        height: 50,
        buttonSize: 40,
        alignLabel: const Alignment(0.2, 0),
        shimmer: true,
        highlightedColor: context.color.secondaryText,
        baseColor: context.color.mainText,
        action: () {
          state.endCurrentInterval();
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: context.color.playIconColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            CupertinoIcons.arrow_right,
            color: state.timerType.workoutColor(context),
          ),
        ),
      ),
    );
  }

  Widget _buildTime() {
    return Observer(
      builder: (_) {
        final currentInterval = state.currentInterval;
        bool isFirstSecond = currentInterval.isFirstSecond;
        String text;
        if (currentInterval.type == WorkoutIntervalType.countdown) {
          if (isFirstSecond && state.currentState != TimerStatus.run) {
            return const PlayIcon();
          } else {
            text = state.currentTime != null
                ? durationToString2(
                    state.currentTime!,
                    isCountdown: currentInterval.isCountdown,
                  )
                : '– –';
          }
        } else {
          text = isFirstSecond
              ? currentInterval.type.redableName
              : state.currentTime != null
                  ? durationToString2(
                      state.currentTime!,
                      isCountdown: currentInterval.isCountdown,
                    )
                  : '– –';
        }
        final timeParts = text.split(':');

        if (text.length != 2) {
          return Text(
            text,
            style: context.textTheme.headlineSmall,
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: timeParts
              .map(
                (e) => _buildTimeDigits(e),
              )
              .addSeparator(Container(
                alignment: Alignment.center,
                width: 24,
                child: Text(
                  ':',
                  style: context.textTheme.headlineSmall,
                ),
              )),
        );
      },
    );
  }

  Widget _buildTimeDigits(String digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: digits
          .split('')
          .map((digit) => Container(
                alignment: Alignment.center,
                width: 50,
                child: Text(
                  digit,
                  style: context.textTheme.headlineSmall,
                ),
              ))
          .toList(),
    );
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
