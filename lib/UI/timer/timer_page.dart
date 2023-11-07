import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/UI/timer/timer_state.dart';
import 'package:smart_timer/UI/timer/widgets/complete_button.dart';
import 'package:smart_timer/UI/timer/widgets/completed_state.dart';
import 'package:smart_timer/analytics/analytics_manager.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/services/app_review_service.dart';
import 'package:smart_timer/utils/duration.extension.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../history/history_state.dart';
import '../timer_types/timer_settings_interface.dart';
import '../widgets/play_icon.dart';
import 'timer_progress_container.dart';

@RoutePage()
class TimerPage extends StatefulWidget {
  const TimerPage({required this.timerSettings, Key? key}) : super(key: key);
  final TimerSettingsInterface timerSettings;

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with SingleTickerProviderStateMixin {
  StreamSubscription? timerSubscription;

  late final TimerState state;

  late final AnimationController controller;

  late final ReactionDisposer timeReactionDisposer;

  var runAnimation = true;
  final curve = Curves.linear;

  @override
  void initState() {
    state = TimerState(
      workout: widget.timerSettings.workout,
      timerType: widget.timerSettings.type,
    );
    AnalyticsManager.eventTimerOpened.setProperty('timer_type', widget.timerSettings.type.name).commit();

    WakelockPlus.enable();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 100),
      reverseDuration: const Duration(microseconds: 300),
    );

    timeReactionDisposer = reaction(
      (p0) => state.status,
      (status) {
        switch (status) {
          case ReadyStatus():
            controller.animateTo(0, duration: const Duration(milliseconds: 500));
          case RunStatus():
            final shareOfTotalDuration = status.shareOfTotalDuration;
            print('#TIMER# shareOfTotalDuration: $shareOfTotalDuration');
            if (shareOfTotalDuration != null) {
              if (shareOfTotalDuration == 0.0) {
                runAnimation = false;
                controller.animateTo(0, duration: const Duration(milliseconds: 500));
                Future.delayed(const Duration(milliseconds: 500), () => runAnimation = true);
              } else if (runAnimation) {
                controller.animateTo(shareOfTotalDuration, duration: const Duration(milliseconds: 100));
              }
            }
            break;
          case PauseStatus():
          case DoneStatus():
            break;
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() async {
    if (state.status is DoneStatus) {
      _requestAppReview();
    }

    timerSubscription?.cancel();
    WakelockPlus.disable();
    // if (state.currentState != TimerStatus.ready) {
    //   context.read<HistoryState>().saveTraining(
    //         finishAt: DateTime.now(), //TODO: подумать какой время сохранить
    //         name: '',
    //         description: '',
    //         workoutSettings: widget.timerSettings.settings,
    //         timerType: widget.timerSettings.type,
    //         result: state.workout.toResult(),
    //         isFinished: state.currentState == TimerStatus.done,
    //       );
    // }
    AnalyticsManager.eventTimerClosed
        .setProperty('status', state.status.name)
        .setProperty('timer_type', state.timerType.name)
        .commit();

    timeReactionDisposer();
    controller.dispose();

    state.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (state.status is! ReadyStatus && state.status is! DoneStatus) {
          final res = await _showConfirmExitAlert();
          return res ?? false;
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
                builder: (ctx) =>
                    state.status is DoneStatus ? CompletedState(timerType: state.timerType) : _buildTimerContainer(),
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
            final status = state.status;
            return GestureDetector(
              onTap: () {
                switch (status) {
                  case ReadyStatus():
                    state.start();
                    break;
                  case RunStatus():
                    state.pause();
                    break;
                  case PauseStatus():
                    state.resume();
                    break;
                  case DoneStatus():
                    break;
                }
              },
              child: TimerProgressContainer(
                color: state.timerType.workoutColor(context),
                timerStatus: state.status,
                controller: controller,
                child: SizedBox.expand(
                  child: Column(
                    children: [
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Observer(builder: (_) {
                            final status = state.status;
                            switch (status) {
                              case ReadyStatus():
                              case DoneStatus():
                                return const SizedBox();
                              case RunStatus():
                                return Text(
                                  status.type.redableName,
                                  style: context.textTheme.titleSmall,
                                );
                              case PauseStatus():
                                return Text(
                                  status.type.redableName,
                                  style: context.textTheme.titleSmall,
                                );
                            }
                          }),
                          const SizedBox(height: 10),
                          _buildTime(status),
                          const SizedBox(height: 10),
                          _buildRoudsInfo(status),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _totalTime(),
                            // !state.workout.currentInterval.isCountdown && state.countdownInterval.isEnded
                            //     ? CompleteButton(
                            //         action: state.endCurrentInterval,
                            //         iconColor: state.timerType.workoutColor(context),
                            //       )
                            //     : const SizedBox(),
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
      switch (state.status) {
        case RunStatus():
          return TextButton(
            onPressed: () => state.pause(),
            child: Text(
              LocaleKeys.timer_pause.tr(),
              style: context.textTheme.bodyMedium,
            ),
          );
        case PauseStatus():
          return TextButton(
            onPressed: () => state.resume(),
            child: Text(
              LocaleKeys.timer_resume.tr(),
              style: context.textTheme.bodyMedium,
            ),
          );
        case DoneStatus():
        case ReadyStatus():
          return const SizedBox();
      }
    });
  }

  Widget _buildTime(TimerStatus status) {
    return SizedBox(
      height: PlayIcon.size,
      child: Builder(
        builder: (_) {
          switch (status) {
            case ReadyStatus():
              return const PlayIcon();
            case RunStatus():
              return Text(
                status.time.durationToString(isCountdown: true),
                style: context.textTheme.headlineSmall,
              );
            case PauseStatus():
              return Text(
                status.time.durationToString(isCountdown: true),
                style: context.textTheme.headlineSmall,
              );
            case DoneStatus():
              return const SizedBox();
          }
          // final currentInterval = state.currentInterval;
          // bool isFirstSecond = currentInterval.isFirstSecond;
          // String text;
          // if (currentInterval.type == WorkoutIntervalType.countdown) {
          //   if (state.currentState != TimerStatus.run) {
          //     return const PlayIcon();
          //   } else {
          //     text = currentTime != null ? currentTime.durationToString(isCountdown: true) : '– –';
          //   }
          // } else {
          //   text = isFirstSecond
          //       ? currentInterval.type.redableName
          //       : currentTime != null
          //           ? currentTime.durationToString(isCountdown: currentInterval.isCountdown)
          //           : '– –';
          // }
          // return Text(text, style: context.textTheme.headlineSmall);
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

  Widget _buildRoudsInfo(TimerStatus status) {
    return Text(
      status.roundsInfo,
      style: context.textTheme.displayMedium,
      textAlign: TextAlign.center,
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
