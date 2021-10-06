import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/stores/timer_store.dart';
import 'package:smart_timer/utils/string_utils.dart';

class TimerPage extends StatefulWidget {
  TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late final TimerState timerState;

  // AudioPlayer audioPlayer = AudioPlayer();
  final player = AudioPlayer();
  late final Duration? duration;

  @override
  void initState() {
    timerState = Provider.of<TimerState>(context, listen: false);
    // audioPlayer.play('assets/sounds/countdown1.mp3', isLocal: true);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initAudio() async {
    duration = await player.setAsset('assets/sounds/countdown1.mp3');
    player.play();
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
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Observer(
                builder: (_) => Text(
                  timerState.intervalIndex.toString(),
                  style: AppFonts.body,
                ),
              ),
              Observer(
                builder: (_) => Text(
                  durationToString(timerState.restTime),
                  style: const TextStyle(
                    fontSize: 52,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      timerState.restart();
                    },
                    icon: const Icon(
                      Icons.restart_alt_rounded,
                      size: 40,
                      color: Colors.blueAccent,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      timerState.start();
                    },
                    icon: const Icon(
                      Icons.play_arrow,
                      size: 40,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
