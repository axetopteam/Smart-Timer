import 'interval_type.dart';

class Interval {
  Interval({required this.duration, required this.type, required this.reminders});
  final Duration duration;
  final IntervalType type;
  final List<Duration> reminders;
}
