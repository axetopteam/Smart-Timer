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

  int get isSecondsCeil {
    return (inMilliseconds / 1000).ceil();
  }
}
