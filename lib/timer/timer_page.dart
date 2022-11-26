import 'dart:async';

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
    audio.initialize();

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
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Observer(
                builder: (ctx) => state.status == TimerStatus.done
                    ? const Center(
                        child: Text('Finish', style: AppFonts.header),
                      )
                    : Column(
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
                                    case TimerStatus.stop:
                                      state.start();
                                      break;
                                    case TimerStatus.run:
                                      state.pause();
                                      audio.pause();

                                      break;
                                    case TimerStatus.pause:
                                      state.restart();
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
                                  color: context.color.amrapColor,
                                  timerStatus: state.status,
                                  partOfHeight: currentIntervalDurationInSeconds != null
                                      ? (currentIntervalDurationInSeconds - (currentTime?.inSeconds ?? 0)) /
                                          currentIntervalDurationInSeconds
                                      : 0,
                                  child: SizedBox.expand(
                                    child: Column(
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
                                          print('#TIME: $text');
                                          return Text(
                                            text,
                                            style: context.textTheme.headline5,
                                          );
                                        }),
                                        const SizedBox(height: 10),
                                        _buildRoudsInfo(),
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
                                    return Text('Tap to pause');
                                  case TimerStatus.pause:
                                    return Text('Tap to resume');
                                  case TimerStatus.done:
                                  case TimerStatus.stop:
                                    return Container();
                                }
                              }),
                            ),
                          ),
                        ],
                      )

                //  Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                // const SizedBox(height: 12),
                // Observer(
                //   builder: (ctx) {
                //     Icon icon;
                //     void Function() onPressed;
                //     switch (state.status) {
                //       case TimerStatus.stop:
                //         icon = const Icon(
                //           Icons.play_arrow,
                //           size: 40,
                //           color: Colors.blueAccent,
                //         );
                //         onPressed = () => state.start();
                //         break;
                //       case TimerStatus.run:
                //         icon = const Icon(
                //           Icons.pause,
                //           size: 40,
                //           color: Colors.blueAccent,
                //         );
                //         onPressed = () {
                //           state.pause();
                //           audio.pause();
                //         };
                //         break;
                //       case TimerStatus.pause:
                //         icon = const Icon(
                //           Icons.play_arrow,
                //           size: 40,
                //           color: Colors.blueAccent,
                //         );
                //         onPressed = () {
                //           state.restart();
                //           if (state.countdownInterval.isEnded) {
                //             audio.resume();
                //           }
                //         };
                //         break;
                //       case TimerStatus.done:
                //         icon = const Icon(
                //           Icons.restart_alt,
                //           size: 40,
                //           color: Colors.blueAccent,
                //         );
                //         onPressed = () => state.start();
                //         break;
                //     }
                //     return IconButton(
                //       onPressed: onPressed,
                //       icon: icon,
                //     );
                //   },
                // ),
                //       const SizedBox(height: 8),
                //       Observer(
                //         builder: (ctx) {
                //           if (!state.workout.currentInterval.isCountdown) {
                //             return IconButton(
                //               onPressed: () {
                //                 state.workout.setDuration();
                //               },
                //               icon: const Icon(
                //                 Icons.check_circle_rounded,
                //                 size: 40,
                //                 color: Colors.blueAccent,
                //               ),
                //             );
                //           } else {
                //             return Container();
                //           }
                //         },
                //       ),
                //     ],
                //   ),
                ),
          ),
        ),
      ),
    );
  }

  _buildRoudsInfo() {
    return Observer(builder: (_) {
      StringBuffer buffer = StringBuffer();
      final workout = state.workout;
      switch (state.timerType) {
        case TimerType.amrap:
          buffer.write('AMRAP ${workout.indexes[2]![0]}/${workout.indexes[2]![1]}');
          break;
        case TimerType.afap:
        case TimerType.emom:
        case TimerType.tabata:
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
            duration: Duration(milliseconds: 1000),
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
