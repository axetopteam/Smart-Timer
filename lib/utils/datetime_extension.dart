extension DateTimeUtils on DateTime {
  DateTime roundToSeconds() {
    final extraMillisecond = (microsecond / 1000).round();
    final roundedMilliseconds = ((millisecond + extraMillisecond) / 100).round() * 100;

    final roundedNow = DateTime.utc(
      year,
      month,
      day,
      hour,
      minute,
      second,
      roundedMilliseconds,
    );

    return roundedNow;
  }

  DateTime roundToDecimalSeconds() {
    final roundedNow = DateTime(
      year,
      month,
      day,
      hour,
      minute,
      second,
      millisecond,
    );
    return roundedNow;
  }
}
