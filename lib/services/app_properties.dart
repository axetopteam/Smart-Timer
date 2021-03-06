import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppProperties {
  late SharedPreferences preferences;
  final String _amrapSettingsKey = 'amrapSettings';
  final String _afapSettingsKey = 'afapSettings';
  final String _tabataSettingsKey = 'tabataSettings';
  final String _emomSettingsKey = 'emomSettings';
  final String _customSettingsKey = 'customSettings';
  final String _workRestSettingsKey = 'workRestSettings';

  Future<bool> initializeProperties() async {
    preferences = await SharedPreferences.getInstance();
    return true;
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

  Future<bool> setJson(String key, Map<String, dynamic> json) {
    return preferences.setString(key, jsonEncode(json));
  }

  Map<String, dynamic>? getJson(String key) {
    final jsonString = preferences.getString(key);
    if (jsonString != null) {
      final json = jsonDecode(jsonString);
      return json;
    }
    return null;
  }
}
