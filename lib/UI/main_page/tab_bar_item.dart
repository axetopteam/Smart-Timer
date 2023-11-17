import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';

enum TabBarItem {
  main,
  workouts,
  settings;

  IconData get icon {
    switch (this) {
      case TabBarItem.main:
        return CupertinoIcons.timer_fill;
      case TabBarItem.workouts:
        return Icons.history;
      case TabBarItem.settings:
        return CupertinoIcons.settings;
    }
  }

  String get label {
    switch (this) {
      case TabBarItem.main:
        return LocaleKeys.tab_bar_items_main.tr();
      case TabBarItem.workouts:
        return LocaleKeys.tab_bar_items_workouts.tr();
      case TabBarItem.settings:
        return LocaleKeys.tab_bar_items_settings.tr();
    }
  }
}
