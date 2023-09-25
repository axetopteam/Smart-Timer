import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// AppProperties singleton class

class AppProperties {
  static final AppProperties _internalSingleton = AppProperties._internal();
  factory AppProperties() => _internalSingleton;
  AppProperties._internal();

  late SharedPreferences _preferences;
  final String _userIdKey = 'userId';
  final String _firstLaunchKey = 'firstLaunch';
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
  final String _countdownDurationKey = 'countdownDuration';

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

  Future<bool> setAmrapSettings(Uint8List buffer) {
    return _preferences.setString(_amrapSettingsKey, HexUtils.encode(buffer));
  }

  Uint8List? getAmrapSettings() {
    final hex = _preferences.getString(_amrapSettingsKey);
    return hex != null ? HexUtils.decode(hex) : null;
  }

  Future<bool> setAfapSettings(Map<String, dynamic> json) {
    return _preferences.setJson(_afapSettingsKey, json);
  }

  Map<String, dynamic>? getAfapSettings() {
    return _preferences.getJson(_afapSettingsKey);
  }

  Future<bool> setTabataSettings(Map<String, dynamic> json) {
    return _preferences.setJson(_tabataSettingsKey, json);
  }

  Map<String, dynamic>? getTabataSettings() {
    return _preferences.getJson(_tabataSettingsKey);
  }

  Future<bool> setEmomSettings(Map<String, dynamic> json) {
    return _preferences.setJson(_emomSettingsKey, json);
  }

  Map<String, dynamic>? getEmomSettings() {
    return _preferences.getJson(_emomSettingsKey);
  }

  Future<bool> setCustomSettings(Map<String, dynamic> json) {
    return _preferences.setJson(_customSettingsKey, json);
  }

  Map<String, dynamic>? getCustomSettings() {
    return _preferences.getJson(_customSettingsKey);
  }

  Future<bool> setWorkRestSettings(Map<String, dynamic> json) {
    return _preferences.setJson(_workRestSettingsKey, json);
  }

  Map<String, dynamic>? getWorkRestSettings() {
    return _preferences.getJson(_workRestSettingsKey);
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
}

extension on SharedPreferences {
  Future<bool> setJson(String key, Map<String, dynamic> json) {
    return setString(key, jsonEncode(json));
  }

  Map<String, dynamic>? getJson(String key) {
    final jsonString = getString(key);
    if (jsonString != null) {
      final json = jsonDecode(jsonString);
      return json;
    }
    return null;
  }

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
