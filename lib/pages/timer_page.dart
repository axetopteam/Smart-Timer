import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/stores/timer_status.dart';
import 'package:smart_timer/stores/timer_store.dart';
import 'package:smart_timer/utils/string_utils.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late final TimerState timerState;

  // AudioPlayer audioPlayer = AudioPlayer();
  final player = AudioPlayer();
  late Duration? duration;
  late final ReactionDisposer reactionDispose;

  @override
  void initState() {
    timerState = Provider.of<TimerState>(context, listen: false);
    reactionDispose = reaction<Duration>(
      (reac) {
        return timerState.time;
      },
      (rest) async {
        if ((timerState.currentInterval.isCountdown && rest.inSeconds == 3) ||
            (!timerState.currentInterval.isCountdown && timerState.currentInterval.duration != null && rest == timerState.currentInterval.duration! - const Duration(seconds: 3))) {
          await player.play();
          await player.pause();
          player.seek(const Duration(milliseconds: 0));
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    player.stop();
    reactionDispose();
    super.dispose();
  }

  Future<void> initAudio() async {
    duration = await player.setAsset('assets/sounds/countdown2.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initAudio(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Timer'),
            foregroundColor: AppColors.white,
          ),
          body: SizedBox(
            width: double.infinity,
            child: Observer(
              builder: (ctx) => timerState.status == TimerStatus.done
                  ? const Center(
                      child: Text('Finish', style: AppFonts.header),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Observer(
                          builder: (_) => Text(
                            '${timerState.roundNumber}/${timerState.roundsCount}',
                            style: AppFonts.header2,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Observer(
                          builder: (_) => Text(
                            timerState.currentType == IntervalType.rest ? 'Rest' : 'Work',
                            style: AppFonts.header2,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Observer(
                          builder: (_) => Text(
                            durationToString2(timerState.time),
                            style: const TextStyle(
                              fontSize: 52,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Observer(builder: (ctx) {
                          Icon icon;
                          void Function() onPressed;
                          switch (timerState.status) {
                            case TimerStatus.stop:
                              icon = const Icon(
                                Icons.play_arrow,
                                size: 40,
                                color: Colors.blueAccent,
                              );
                              onPressed = timerState.start;
                              break;
                            case TimerStatus.run:
                              icon = const Icon(
                                Icons.pause,
                                size: 40,
                                color: Colors.blueAccent,
                              );
                              onPressed = timerState.pause;
                              break;
                            case TimerStatus.pause:
                              icon = const Icon(
                                Icons.play_arrow,
                                size: 40,
                                color: Colors.blueAccent,
                              );
                              onPressed = timerState.resume;
                              break;
                            case TimerStatus.done:
                              icon = const Icon(
                                Icons.restart_alt,
                                size: 40,
                                color: Colors.blueAccent,
                              );
                              onPressed = timerState.start;
                              break;
                          }
                          return IconButton(
                            onPressed: onPressed,
                            icon: icon,
                          );
                        }),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
