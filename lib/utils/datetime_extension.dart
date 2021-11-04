extension DateTimeUtils on DateTime {
  DateTime roundToSeconds() {
    // final extraSecond = ((millisecond * 1000 + microsecond) / 1000000).round();
    // final roundedNow = DateTime(
    //   year,
    //   month,
    //   day,
    //   hour,
    //   minute,
    //   second + extraSecond,
    // );
    final extraMillisecond = (microsecond / 1000).round();

    final roundedMilliseconds = ((millisecond + extraMillisecond) / 100).round() * 100;

    final roundedNow = DateTime(
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
    final extraMillisecond = (microsecond / 1000).round();
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
