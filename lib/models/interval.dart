import 'package:flutter/material.dart';

import 'interval_type.dart';

@immutable
class Interval {
  Interval({
    required this.duration,
    required this.type,
    this.isCountdown = true,
  })  : assert(!isCountdown || duration != null),
        reminders = [if (duration != null) Duration(seconds: duration.inSeconds ~/ 2)];

  final Duration? duration;
  final IntervalType type;
  final bool isCountdown;
  final List<Duration> reminders;
}
