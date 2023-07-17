import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// AppProperties singleton class

class AppProperties {
  static final AppProperties _internalSingleton = AppProperties._internal();
  factory AppProperties() => _internalSingleton;
  AppProperties._internal();

  late SharedPreferences _preferences;
  final String _userIdKey = 'userId';
  final String _amrapSettingsKey = 'amrapSettings';
  final String _afapSettingsKey = 'afapSettings';
  final String _tabataSettingsKey = 'tabataSettings';
  final String _emomSettingsKey = 'emomSettings';
  final String _customSettingsKey = 'customSettings';
  final String _workRestSettingsKey = 'workRestSettings';
  final String _soundOnKey = 'soundOn';
  final String _lastTimersEndTimesKey = 'lastTimersEndTimes';
  final String _rateSuggestionShowedAtKey = 'rateSuggestionShowedAt';
  final String _rateSuggestionShowedVersionKey = 'rateSuggestionShowedVersion';

  Future<bool> initializeProperties() async {
    _preferences = await SharedPreferences.getInstance();
    return true;
  }

  String? get userId {
    return _preferences.getString(_userIdKey);
  }

  Future<bool?> setUserId(String? value) async {
    if (value != null) {
      return await _preferences.setString(_userIdKey, value);
    }
    return null;
  }

  Future<bool> setAmrapSettings(Map<String, dynamic> json) {
    return setJson(_amrapSettingsKey, json);
  }

  Map<String, dynamic>? getAmrapSettings() {
    return getJson(_amrapSettingsKey);
  }

  Future<bool> setAfapSettings(Map<String, dynamic> json) {
    return setJson(_afapSettingsKey, json);
  }

  Map<String, dynamic>? getAfapSettings() {
    return getJson(_afapSettingsKey);
  }

  Future<bool> setTabataSettings(Map<String, dynamic> json) {
    return setJson(_tabataSettingsKey, json);
  }

  Map<String, dynamic>? getTabataSettings() {
    return getJson(_tabataSettingsKey);
  }

  Future<bool> setEmomSettings(Map<String, dynamic> json) {
    return setJson(_emomSettingsKey, json);
  }

  Map<String, dynamic>? getEmomSettings() {
    return getJson(_emomSettingsKey);
  }

  Future<bool> setCustomSettings(Map<String, dynamic> json) {
    return setJson(_customSettingsKey, json);
  }

  Map<String, dynamic>? getCustomSettings() {
    return getJson(_customSettingsKey);
  }

  Future<bool> setWorkRestSettings(Map<String, dynamic> json) {
    return setJson(_workRestSettingsKey, json);
  }

  Map<String, dynamic>? getWorkRestSettings() {
    return getJson(_workRestSettingsKey);
  }

  bool get soundOn {
    return _preferences.getBool(_soundOnKey) ?? true;
  }

  Future<bool> saveSoundOn(bool value) {
    return _preferences.setBool(_soundOnKey, value);
  }

  Future<bool> setJson(String key, Map<String, dynamic> json) {
    return _preferences.setString(key, jsonEncode(json));
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

  Map<String, dynamic>? getJson(String key) {
    final jsonString = _preferences.getString(key);
    if (jsonString != null) {
      final json = jsonDecode(jsonString);
      return json;
    }
    return null;
  }
}
