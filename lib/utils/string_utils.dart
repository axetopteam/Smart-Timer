const minutesPerHour = 60;
const secondsPerMinute = 60;

String durationToString(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  if (duration.inMicroseconds < 0) {
    return "-${-duration}";
  }
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(minutesPerHour));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(secondsPerMinute));

  return "${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds";
}

String durationToString2(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  if (duration.inMicroseconds < 0) {
    return "-${-duration}";
  }
  String twoDigitMinutes = twoDigits(duration.inMinutes);
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(secondsPerMinute));

  return "$twoDigitMinutes:$twoDigitSeconds";
}
