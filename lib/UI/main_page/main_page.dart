import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/routes/router.dart';

import 'tab_bar_item.dart';

@RoutePage<void>()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final List<PageRouteInfo<void>> _routes;
  @override
  void initState() {
    _routes = [
      const FavoritesRouter(),
      const SettingsRoute(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: _routes,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushRoute(const NewTimerRouter());
        },
        child: const Icon(CupertinoIcons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBuilder: (ctx, tabsRouter) => AnimatedBottomNavigationBar.builder(
        itemCount: 2,
        tabBuilder: (index, isActive) {
          final barItem = TabBarItem.values[index];
          final color = isActive
              ? context.theme.bottomNavigationBarTheme.selectedItemColor
              : context.theme.bottomNavigationBarTheme.unselectedItemColor;

          return Column(
            children: [
              const SizedBox(height: 8),
              Icon(barItem.icon, color: color),
              const SizedBox(height: 4),
              Text(
                barItem.label,
                style: context.textTheme.bodyMedium?.copyWith(color: color),
              ),
            ],
          );
        },
        activeIndex: tabsRouter.activeIndex,
        gapLocation: GapLocation.none,
        onTap: tabsRouter.setActiveIndex,
        backgroundColor: Colors.blueGrey,
        blurEffect: false,
        scaleFactor: 0,
        splashRadius: 0,
      ),
    );
  }
}
