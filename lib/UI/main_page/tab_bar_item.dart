import 'package:flutter/cupertino.dart';

enum TabBarItem {
  favorites,
  settings;

  IconData get icon {
    switch (this) {
      case TabBarItem.favorites:
        return CupertinoIcons.square_favorites_fill;
      case TabBarItem.settings:
        return CupertinoIcons.settings;
    }
  }

  String get label {
    switch (this) {
      case TabBarItem.favorites:
        return 'Избранное';
      case TabBarItem.settings:
        return 'Настройки';
    }
  }
}
