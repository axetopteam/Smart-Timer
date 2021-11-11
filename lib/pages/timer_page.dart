import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/services/audio_service.dart';
import 'package:smart_timer/stores/timer.dart';
import 'package:smart_timer/stores/timer_status.dart';
import 'package:smart_timer/utils/string_utils.dart';
import 'package:wakelock/wakelock.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late final Timer state;
  AudioService audio = AudioService();

  // AudioPlayer audioPlayer = AudioPlayer();
  // late final ReactionDisposer reactionDispose;

  StreamSubscription? timerSubscription;

  @override
  void initState() {
    Wakelock.enable();
    audio.initialize();

    state = Provider.of<Timer>(context, listen: false);

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
        title: const Text('Timer'),
        foregroundColor: AppColors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Observer(
          builder: (ctx) => state.status == TimerStatus.done
              ? const Center(
                  child: Text('Finish', style: AppFonts.header),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Observer(
                      builder: (_) => Text(
                        'Is Last: ${state.workout.isLast}',
                        style: AppFonts.header2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Observer(
                      builder: (_) => Text(
                        state.indexes,
                        style: AppFonts.header2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    Observer(builder: (_) {
                      final currentInterval = state.currentInterval;
                      bool isFirstSecond = currentInterval.isFirstSecond;
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
                        style: const TextStyle(
                          fontSize: 52,
                        ),
                      );
                    }),
                    const SizedBox(height: 12),
                    Observer(
                      builder: (ctx) {
                        Icon icon;
                        void Function() onPressed;
                        switch (state.status) {
                          case TimerStatus.stop:
                            icon = const Icon(
                              Icons.play_arrow,
                              size: 40,
                              color: Colors.blueAccent,
                            );
                            onPressed = () => state.start();
                            break;
                          case TimerStatus.run:
                            icon = const Icon(
                              Icons.pause,
                              size: 40,
                              color: Colors.blueAccent,
                            );
                            onPressed = () {
                              state.pause();
                              audio.pause();
                            };
                            break;
                          case TimerStatus.pause:
                            icon = const Icon(
                              Icons.play_arrow,
                              size: 40,
                              color: Colors.blueAccent,
                            );
                            onPressed = () {
                              state.restart();
                              if (state.countdownInterval.isEnded) {
                                audio.resume();
                              }
                            };
                            break;
                          case TimerStatus.done:
                            icon = const Icon(
                              Icons.restart_alt,
                              size: 40,
                              color: Colors.blueAccent,
                            );
                            onPressed = () => state.start();
                            break;
                        }
                        return IconButton(
                          onPressed: onPressed,
                          icon: icon,
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Observer(
                      builder: (ctx) {
                        if (!state.workout.currentInterval.isCountdown) {
                          return IconButton(
                            onPressed: () {
                              state.workout.setDuration();
                            },
                            icon: const Icon(
                              Icons.check_circle_rounded,
                              size: 40,
                              color: Colors.blueAccent,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
