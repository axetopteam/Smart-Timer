import 'interval_type.dart';

class Interval {
  Interval({
    required this.duration,
    required this.type,
  }) : reminders = [Duration(seconds: duration.inSeconds ~/ 2)];

  final Duration duration;
  final IntervalType type;
  final List<Duration> reminders;
}
