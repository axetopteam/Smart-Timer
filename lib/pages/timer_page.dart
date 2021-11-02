import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:smart_timer/application/application_theme.dart';
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
  late final ReactionDisposer reactionDispose;

  @override
  void initState() {
    Wakelock.enable();
    audio.initialize();

    state = Provider.of<Timer>(context, listen: false);
    reactionDispose = reaction<Duration?>(
      (reac) {
        return state.currentTime;
      },
      (rest) async {
        if (((!state.countdownInterval.isEnded || state.workout.currentInterval.isCountdown) && state.currentTime?.inSeconds == 3))
        //  ||
        // (!workout.currentInterval.isCountdown && workout.currentInterval.duration != null && rest == workout.currentInterval.duration! - const Duration(seconds: 3)))
        {
          audio.playCountdown();
        }
      },
    );

    reaction<bool>(
      (reac) {
        return state.workout.isLast;
      },
      (rest) async {
        if (state.workout.isLast) {
          audio.playLastRound();
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() async {
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
                    // Observer(
                    //   builder: (_) => Text(
                    //     workout.currentType.desc,
                    //     style: AppFonts.header2,
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    Observer(
                      builder: (_) => Text(
                        state.currentTime != null ? durationToString2(state.currentTime!) : '--',
                        style: const TextStyle(
                          fontSize: 52,
                        ),
                      ),
                    ),
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
                            onPressed = state.pause;
                            break;
                          case TimerStatus.pause:
                            icon = const Icon(
                              Icons.play_arrow,
                              size: 40,
                              color: Colors.blueAccent,
                            );
                            onPressed = () => state.restart();
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
                    SizedBox(height: 8),
                    Observer(
                      builder: (ctx) {
                        if (state.workout.currentInterval.duration == null) {
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
