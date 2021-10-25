extension DateTimeUtils on DateTime {
  DateTime roundToSeconds() {
    final extraSecond = ((millisecond * 1000 + microsecond) / 1000000).round();
    final roundedNow = DateTime(
      year,
      month,
      day,
      hour,
      minute,
      second + extraSecond,
    );
    return roundedNow;
  }
}
