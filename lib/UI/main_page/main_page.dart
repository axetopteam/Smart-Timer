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
      const HistoryRoute(),
      const SettingsRoute(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AutoTabsScaffold(
        routes: _routes,
        lazyLoad: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushRoute(const NewTimerRouter());
          },
          child: const Icon(CupertinoIcons.add),
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBuilder: (ctx, tabsRouter) => CupertinoTabBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: (index) => tabsRouter.setActiveIndex(index),
          activeColor: context.theme.iconTheme.color,
          items: TabBarItem.values
              .map((TabBarItem e) => BottomNavigationBarItem(
                    icon: Icon(e.icon),
                    label: e.label,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
