import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/services/audio_service.dart';
import 'package:smart_timer/timer/timer_state.dart';
import 'package:smart_timer/utils/string_utils.dart';
import 'package:smart_timer/widgets/play_icon.dart';
import 'package:wakelock/wakelock.dart';

import 'timer_status.dart';
import 'timer_type.dart';

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

    // reaction<bool>(
    //   (reac) {
    //     return state.workout.isLast;
    //   },
    //   (rest) async {
    //     if (state.workout.isLast) {
    //       audio.playLastRound();
    //     }
    //   },
    // );
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
    return Scaffold(
      appBar: AppBar(
        title: Text(state.timerType.readbleName),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child:
                Observer(builder: (ctx) => state.status == TimerStatus.done ? _buildFinish() : _buildTimerContainer()),
          ),
        ),
      ),
    );
  }

  Column _buildTimerContainer() {
    return Column(
      children: [
        const Spacer(),
        Expanded(
          flex: 4,
          child: Observer(builder: (context) {
            final currentInterval = state.currentInterval;
            final currentTime = state.currentTime;
            final currentIntervalDurationInSeconds = currentInterval.duration?.inSeconds;
            return GestureDetector(
              onTap: () {
                switch (state.status) {
                  case TimerStatus.ready:
                    state.start();
                    break;
                  case TimerStatus.run:
                    state.pause();
                    audio.pause();
                    break;
                  case TimerStatus.pause:
                    state.resume();
                    if (state.countdownInterval.isEnded) {
                      audio.resume();
                    }
                    break;
                  case TimerStatus.done:
                    state.start();
                    break;
                }
              },
              child: TimerBackgroundContainer(
                color: workoutColor(),
                timerStatus: state.status,
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
                              currentInterval.type.desc,
                              style: context.textTheme.subtitle2,
                            );
                          }),
                          const SizedBox(height: 10),
                          Observer(builder: (_) {
                            final currentInterval = state.currentInterval;
                            bool isFirstSecond = currentInterval.isFirstSecond;
                            if (currentInterval.type == IntervalType.countdown) {
                              if (isFirstSecond && state.status != TimerStatus.run) {
                                return const PlayIcon();
                              } else {
                                return Text(
                                  state.currentTime != null
                                      ? durationToString2(
                                          state.currentTime!,
                                          isCountdown: currentInterval.isCountdown,
                                        )
                                      : '--',
                                  style: context.textTheme.headline5,
                                );
                              }
                            }
                            final text = isFirstSecond
                                ? currentInterval.type.desc
                                : state.currentTime != null
                                    ? durationToString2(
                                        state.currentTime!,
                                        isCountdown: currentInterval.isCountdown,
                                      )
                                    : '--';
                            return Text(
                              text,
                              style: context.textTheme.headline5,
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
                                    children: const [
                                      Icon(
                                        Icons.swipe_right,
                                        size: 30,
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'Slide to complete round',
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
          child: Center(
            child: Observer(builder: (context) {
              switch (state.status) {
                case TimerStatus.run:
                  return const Text('Tap to pause');
                case TimerStatus.pause:
                  return const Text('Tap to resume');
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

  Color workoutColor() {
    switch (state.timerType) {
      case TimerType.amrap:
        return context.color.amrapColor;
      case TimerType.afap:
        return context.color.afapColor;
      case TimerType.emom:
        return context.color.emomColor;
      case TimerType.tabata:
        return context.color.tabataColor;
      case TimerType.workRest:
        return context.color.workRestColor;
      case TimerType.custom:
        return context.color.customColor;
    }
  }

  Widget _buildRoudsInfo() {
    return Observer(builder: (_) {
      StringBuffer buffer = StringBuffer();
      final workout = state.workout;
      switch (state.timerType) {
        case TimerType.amrap:
          buffer.write('AMRAP ${workout.indexes[2]![0]}/${workout.indexes[2]![1]}');
          break;
        case TimerType.afap:
          buffer.write('For Time ${workout.indexes[2]![0]}/${workout.indexes[2]![1]}');
          break;
        case TimerType.emom:
        case TimerType.tabata:
        case TimerType.workRest:
        case TimerType.custom:
          for (int i = workout.indexes.length - 1; i > 0; i--) {
            final index = workout.indexes.length - i;
            buffer.write('$index: ${workout.indexes[i]![0]}/${workout.indexes[i]![1]}\n');
          }
      }
      return Text(
        buffer.toString(),
        style: context.textTheme.headline2,
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
            color: workoutColor(),
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
          style: context.textTheme.headline1,
        ),
      ],
    );
  }
}

class TimerBackgroundContainer extends StatelessWidget {
  const TimerBackgroundContainer({
    required this.color,
    required this.child,
    required this.partOfHeight,
    required this.timerStatus,
    Key? key,
  }) : super(key: key);

  final Color color;
  final Widget child;
  final double partOfHeight;
  final TimerStatus timerStatus;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrains) {
      final height = constrains.maxHeight;
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            height: height * partOfHeight,
            decoration: BoxDecoration(
              color: context.color.timerOverlayColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
          ),
          child,
          if (timerStatus == TimerStatus.pause)
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: context.color.pauseOverlayColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const PlayIcon(),
            )
        ],
      );
    });
  }
}
