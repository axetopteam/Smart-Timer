import 'package:smart_timer/services/app_properties.dart';

/// TimerCouterService singleton class
class TimerCouterService {
  static final TimerCouterService _internalSingleton = TimerCouterService._internal();
  factory TimerCouterService() => _internalSingleton;
  TimerCouterService._internal() {
    initialize();
  }

  static const _maxCount = 10;

  final appProperties = AppProperties();

  late final List<DateTime> lastTimersEndTimes;

  void initialize() {
    lastTimersEndTimes = appProperties.lastTimersEndTimes;
  }

  void addNewTime(DateTime dateTime) {
    lastTimersEndTimes.add(dateTime.toUtc());

    if (lastTimersEndTimes.length > _maxCount) {
      lastTimersEndTimes =
          lastTimersEndTimes.sublist(lastTimersEndTimes.length - _maxCount, lastTimersEndTimes.length).toList();
    }

    appProperties.lastTimersEndTimes = lastTimersEndTimes;
  }

  int get todaysCount {
    final now = DateTime.now();
    final beginOfToday = DateTime(now.year, now.month, now.day);
    final todaysTimers = lastTimersEndTimes.where((element) => element.isAfter(beginOfToday));
    return todaysTimers.length;
  }
}
