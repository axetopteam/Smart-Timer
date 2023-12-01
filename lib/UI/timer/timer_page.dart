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

import '../timer_types/timer_settings_interface.dart';
import '../widgets/play_icon.dart';
import 'timer_progress_container.dart';
import 'widgets/animated_countdown.dart';

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
    state = TimerState(timerSettings: widget.timerSettings);
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Observer(builder: (ctx) {
                final status = state.status;
                return status is DoneStatus
                    ? CompletedState(
                        timerType: state.timerType,
                        result: status.result,
                      )
                    : _buildTimerContainer();
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTop(TimerStatus status) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(height: 30),
        switch (status) {
          ReadyStatus() => const SizedBox(),
          DoneStatus() => const SizedBox(),
          RunStatus() => Text(
              status.type.redableName,
              style: context.textStyles.timerInfo,
              textAlign: TextAlign.center,
            ),
          PauseStatus() => Text(
              status.type.redableName,
              style: context.textStyles.timerInfo,
              textAlign: TextAlign.center,
            ),
        },
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildMiddle(TimerStatus status) {
    switch (status) {
      case ReadyStatus():
        return const PlayIcon();
      case DoneStatus():
        return const SizedBox();
      case RunStatus():
        return _buildTime(
          time: status.time,
          isReverse: status.isReverse,
          isCountdown: status.type == ActivityType.countdown,
        );
      case PauseStatus():
        return _buildTime(
          time: status.time,
          isReverse: status.isReverse,
          isCountdown: status.type == ActivityType.countdown,
        );
    }
  }

  Widget _buildBottom(TimerStatus status) {
    switch (status) {
      case DoneStatus():
        return const SizedBox();
      case ReadyStatus():
      case RunStatus():
      case PauseStatus():
        return Column(
          children: [
            const SizedBox(height: 30),
            _buildRoudsInfo(status.indexes),
            _totalTime(),
            const Spacer(),
            if (status is RunStatus && status.canBeCompleted)
              CompleteButton(
                key: ValueKey(status.indexes),
                action: state.completeCurrentInterval,
                iconColor: state.timerType.workoutColor(context),
              ),
            const SizedBox(height: 30),
          ],
        );
    }
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
                      Expanded(child: Align(child: _buildTop(status))),
                      _buildMiddle(status),
                      Expanded(child: _buildBottom(status)),
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

  Widget _buildTime({
    required Duration time,
    required bool isCountdown,
    required bool isReverse,
  }) {
    return Container(
      alignment: Alignment.center,
      height: PlayIcon.size,
      child: isCountdown
          ? AnimatedCountdown(duration: time)
          : Text(
              time.toTimerFormat(isCountdown: isReverse),
              style: context.textTheme.headlineSmall,
            ),
    );
  }

  Widget _totalTime() {
    if (state.timerType.showTotalTime && state.totalRestTime != null) {
      return Observer(builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${LocaleKeys.timer_total_time.tr()}: ${state.totalRestTime!.toTimerFormat(isCountdown: false)}',
            style: context.textTheme.titleMedium,
          ),
        );
      });
    } else {
      return const SizedBox();
    }
  }

  Widget _buildRoudsInfo(List<IntervalIndex> indexes) {
    return Column(
      children: indexes
          .map(
            (index) => Text(
              index.toString(),
              style: context.textStyles.timerInfo,
            ),
          )
          .toList(),
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
