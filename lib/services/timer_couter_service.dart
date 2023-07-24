import 'package:flutter/foundation.dart';
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

  late final List<DateTime> _lastTimersEndTimes;

  void initialize() {
    _lastTimersEndTimes = appProperties.lastTimersEndTimes;
  }

  void addNewTime(DateTime dateTime) {
    _lastTimersEndTimes.add(dateTime.toUtc());

    if (_lastTimersEndTimes.length > _maxCount) {
      _lastTimersEndTimes =
          _lastTimersEndTimes.sublist(_lastTimersEndTimes.length - _maxCount, _lastTimersEndTimes.length).toList();
    }

    appProperties.lastTimersEndTimes = _lastTimersEndTimes;
  }

  int get _todaysCount {
    final now = DateTime.now();
    final beginOfToday = DateTime(now.year, now.month, now.day);
    final todaysTimers = _lastTimersEndTimes.where((element) => element.isAfter(beginOfToday));
    return todaysTimers.length;
  }

  bool get canStartNewTimer => _todaysCount < 2 || kDebugMode;
}
