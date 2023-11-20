const minutesPerHour = 60;
const secondsPerMinute = 60;

String twoDigits(int n) {
  if (n >= 10) return "$n";
  return "0$n";
}

extension DurationX on Duration {
  String get readableString {
    if (inMicroseconds < 0) {
      return "-${(-this).readableString}";
    }
    String twoDigitMinutes = twoDigits(inMinutes);

    String twoDigitSeconds = twoDigits(inSeconds.remainder(secondsPerMinute));

    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  String durationToString({bool isCountdown = false}) {
    if (inMicroseconds < 0) {
      return "-${(-this).durationToString()}";
    }
    final seconds = isCountdown ? isSecondsCeil : inSeconds;
    final minutes = seconds ~/ secondsPerMinute;

    String twoDigitMinutes = twoDigits(minutes);

    String twoDigitSeconds = twoDigits(seconds.remainder(secondsPerMinute));

    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  int get isSecondsCeil {
    return (inMilliseconds / 1000).ceil();
  }
}

Duration minDuration(Duration a, Duration b) {
  return a < b ? a : b;
}
