import 'package:just_audio/just_audio.dart';

class AudioService {
  AudioPlayer countdownPlayer = AudioPlayer();
  AudioPlayer lastRoundPlayer = AudioPlayer();
  AudioPlayer halfTimePlayer = AudioPlayer();

  Future<void> initialize() async {
    await countdownPlayer.setAsset('assets/sounds/countdown2.mp3');
    await lastRoundPlayer.setAsset('assets/sounds/last_round.mp3');
    await halfTimePlayer.setAsset('assets/sounds/last_round.mp3');
  }

  Future<void> playCountdown() async {
    await countdownPlayer.play();
    await countdownPlayer.pause();
    await countdownPlayer.seek(const Duration(milliseconds: 0), index: 0);
  }

  Future<void> playLastRound() async {
    await lastRoundPlayer.play();
    await lastRoundPlayer.pause();
    await lastRoundPlayer.seek(const Duration(milliseconds: 0), index: 0);
  }

  Future<void> playHalfTime() async {
    await halfTimePlayer.play();
    await halfTimePlayer.pause();
    await halfTimePlayer.seek(const Duration(milliseconds: 0), index: 0);
  }

  Future<void> stop() async {
    countdownPlayer.stop();
    lastRoundPlayer.stop();
    halfTimePlayer.stop();
  }

  Future<void> dispose() async {
    countdownPlayer.dispose();
    lastRoundPlayer.dispose();
    halfTimePlayer.dispose();
  }
}
