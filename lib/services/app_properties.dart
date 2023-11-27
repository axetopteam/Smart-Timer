import 'package:shared_preferences/shared_preferences.dart';

/// AppProperties singleton class

class AppProperties {
  static final AppProperties _internalSingleton = AppProperties._internal();
  factory AppProperties() => _internalSingleton;
  AppProperties._internal();

  late SharedPreferences _preferences;
  final String _userIdKey = 'userId';
  final String _firstLaunchKey = 'firstLaunch';

  final String _soundOnKey = 'soundOn';
  final String _lastTimersEndTimesKey = 'lastTimersEndTimes';
  final String _rateSuggestionShowedAtKey = 'rateSuggestionShowedAt';
  final String _rateSuggestionShowedVersionKey = 'rateSuggestionShowedVersion';
  final String _countdownDurationKey = 'countdownDuration';

  final String _introShowedAtKey = 'introShowedAt';

  Future<bool> initializeProperties() async {
    _preferences = await SharedPreferences.getInstance();
    return true;
  }

  String? get userId {
    return _preferences.getString(_userIdKey);
  }

  Future<bool?> setUserId(String value) async {
    return await _preferences.setString(_userIdKey, value);
  }

  DateTime? get firstLaunchDate {
    return _preferences.getDateTime(_firstLaunchKey);
  }

  Future<bool?> setFirstLaunchDate(DateTime value) async {
    return await _preferences.setDateTime(_firstLaunchKey, value);
  }

  bool get soundOn {
    return _preferences.getBool(_soundOnKey) ?? true;
  }

  Future<bool> saveSoundOn(bool value) {
    return _preferences.setBool(_soundOnKey, value);
  }

  set lastTimersEndTimes(List<DateTime> times) {
    _preferences.setStringList(
        _lastTimersEndTimesKey, times.map((e) => e.toUtc().millisecondsSinceEpoch.toString()).toList());
  }

  List<DateTime> get lastTimersEndTimes {
    final timesList = _preferences.getStringList(_lastTimersEndTimesKey) ?? [];
    return timesList.map((e) => DateTime.fromMillisecondsSinceEpoch(int.parse(e), isUtc: true)).toList();
  }

  void rateSuggestionShowedParams(DateTime dateTime, String version) {
    _preferences.setInt(_rateSuggestionShowedAtKey, dateTime.millisecondsSinceEpoch);
    _preferences.setString(_rateSuggestionShowedVersionKey, version);
  }

  ({DateTime? date, String? version}) get rateSuggestionShowParams {
    final millisecondsSinceEpoch = _preferences.getInt(_rateSuggestionShowedAtKey);
    final version = _preferences.getString(_rateSuggestionShowedVersionKey);

    return (
      date: millisecondsSinceEpoch != null
          ? DateTime.fromMicrosecondsSinceEpoch(millisecondsSinceEpoch, isUtc: true)
          : null,
      version: version,
    );
  }

  int get countdownSeconds {
    final seconds = _preferences.getInt(_countdownDurationKey) ?? 10;
    return seconds;
  }

  set countdownSeconds(int? seconds) {
    if (seconds == null) {
      _preferences.remove(_countdownDurationKey);
    } else {
      _preferences.setInt(_countdownDurationKey, seconds);
    }
  }

  DateTime? get introShowedAt {
    return _preferences.getDateTime(_introShowedAtKey);
  }

  setIntroShowedDateTime(DateTime dateTime) {
    _preferences.setDateTime(_introShowedAtKey, dateTime);
  }
}

extension on SharedPreferences {
  Future<bool> setDateTime(String key, DateTime? dateTime) {
    if (dateTime == null) {
      return remove(key);
    }
    return setInt(key, dateTime.millisecondsSinceEpoch);
  }

  DateTime? getDateTime(String key) {
    final millisecondsSinceEpoch = getInt(key);
    if (millisecondsSinceEpoch != null) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
      return dateTime;
    }
    return null;
  }
}
