import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppProperties {
  late SharedPreferences preferences;
  final String _amrapSettingsKey = 'amrapSettings';
  final String _tabataSettingsKey = 'tabataSettings';
  final String _emomSettingsKey = 'emomSettings';

  Future<bool> initializeProperties() async {
    preferences = await SharedPreferences.getInstance();
    return true;
  }

  Future<bool> setAmrapSettings(Map<String, dynamic> json) {
    return preferences.setString(_amrapSettingsKey, jsonEncode(json));
  }

  Map<String, dynamic>? getAmrapSettings() {
    final emomSettingsString = preferences.getString(_amrapSettingsKey);
    if (emomSettingsString != null) {
      final json = jsonDecode(emomSettingsString);
      return json;
    }
  }

  Future<bool> setTabataSettings(Map<String, dynamic> json) {
    return preferences.setString(_tabataSettingsKey, jsonEncode(json));
  }

  Map<String, dynamic>? getTabataSettings() {
    final tabataSettingsString = preferences.getString(_tabataSettingsKey);
    if (tabataSettingsString != null) {
      final json = jsonDecode(tabataSettingsString);
      return json;
    }
  }

  Future<bool> setEmomSettings(Map<String, dynamic> json) {
    return preferences.setString(_emomSettingsKey, jsonEncode(json));
  }

  Map<String, dynamic>? getEmomSettings() {
    final emomSettingsString = preferences.getString(_emomSettingsKey);
    if (emomSettingsString != null) {
      final json = jsonDecode(emomSettingsString);
      return json;
    }
  }
}
