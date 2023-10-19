import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabBarItem {
  favorites,
  history,
  settings;

  IconData get icon {
    switch (this) {
      case TabBarItem.favorites:
        return CupertinoIcons.square_favorites_fill;
      case TabBarItem.history:
        return Icons.history;
      case TabBarItem.settings:
        return CupertinoIcons.settings;
    }
  }

  String get label {
    switch (this) {
      case TabBarItem.favorites:
        return 'Избранное';
      case TabBarItem.history:
        return 'История';
      case TabBarItem.settings:
        return 'Настройки';
    }
  }
}
