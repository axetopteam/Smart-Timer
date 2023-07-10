import 'package:audioplayers/audioplayers.dart';

enum SoundType {
  countdown,
  lastRound,
  halfTime,
  tenSeconds,
}

class AudioService {
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> switchSoundOnOff(bool value) async {
    await audioPlayer.setVolume(value ? 1 : 0);
  }

  Future<void> playCountdown() async {
    await audioPlayer.stop();
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

  Future<void> pauseIfNeeded() async {
    if (audioPlayer.state == PlayerState.playing) {
      await audioPlayer.pause();
    }
  }

  Future<void> resumeIfNeeded() async {
    if (audioPlayer.state == PlayerState.paused) {
      await audioPlayer.resume();
    }
  }

  Future<void> dispose() async {
    await audioPlayer.dispose();
  }
}
