import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        return 'Главное';
      case TabBarItem.workouts:
        return 'Тренировки';
      case TabBarItem.settings:
        return 'Настройки';
    }
  }
}
