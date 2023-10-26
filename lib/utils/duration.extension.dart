import 'package:smart_timer/utils/string_utils.dart';

extension DurationX on Duration {
  String durationToString({bool isCountdown = false}) {
    if (inMicroseconds < 0) {
      return "-${(-this).durationToString}";
    }
    String twoDigitMinutes = twoDigits(inMinutes);
    final seconds = isCountdown ? isSecondsCeil : inSeconds;

    String twoDigitSeconds = twoDigits(seconds.remainder(secondsPerMinute));

    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
