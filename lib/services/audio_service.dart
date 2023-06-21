import 'package:audioplayers/audioplayers.dart';

enum SoundType {
  countdown,
  lastRound,
  halfTime,
  tenSeconds,
}

class AudioService {
  AudioPlayer audioPlayer = AudioPlayer();

  // Future<void> initialize() async {
  //   player = AudioCache(prefix: 'assets/sounds/');
  //   await player.loadAll(['assets/sounds/countdown2.mp3', 'last_round.mp3', 'half_time.mp3', 'ten_seconds.mp3']);
  // }

  Future<void> playCountdown() async {
    await audioPlayer.play(AssetSource('sounds/countdown2.mp3'));
  }

  Future<void> play10Seconds() async {
    await audioPlayer.play(AssetSource('sounds/ten_seconds.mp3'));
  }

  Future<void> playLastRound() async {
    await audioPlayer.play(AssetSource('sounds/last_round.mp3'));
  }

  Future<void> playHalfTime() async {
    if (audioPlayer.state == PlayerState.playing) return; //TODO: refactoring, убрать отсюда логику
    await audioPlayer.play(AssetSource('sounds/half_time.mp3'));
  }

  Future<void> stop() async {
    await audioPlayer.stop();
  }

  Future<void> pause() async {
    await audioPlayer.pause();
  }

  Future<void> resume() async {
    await audioPlayer.resume();
  }

  Future<void> dispose() async {
    await audioPlayer.dispose();
  }
}
