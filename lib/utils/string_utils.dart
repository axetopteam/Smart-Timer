const minutesPerHour = 60;
const secondsPerMinute = 60;

String durationToString2(Duration duration, {bool isCountdown = false}) {
  //TODO: убрать отсюда isCountdown
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  if (duration.inMicroseconds < 0) {
    return "-${-duration}";
  }
  String twoDigitMinutes = twoDigits(duration.inMinutes);
  final seconds = isCountdown ? duration.inSeconds + 1 : duration.inSeconds;

  String twoDigitSeconds = twoDigits(seconds.remainder(secondsPerMinute));

  return "$twoDigitMinutes:$twoDigitSeconds";
}
