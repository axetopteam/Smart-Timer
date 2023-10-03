import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_timer/UI/settings/settings_page.dart';

import '../favorites/favorites_page.dart';
import 'tab_bar_item.dart';

@RoutePage<void>()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return FavouritesPage();
          case 1:
            return SettingsPage();
          default:
            return Container();
        }
      },
      tabBar: CupertinoTabBar(
        items: TabBarItem.values.map((e) => BottomNavigationBarItem(icon: Icon(e.icon))).toList(),
      ),
    );
  }
}
