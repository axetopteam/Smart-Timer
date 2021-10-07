import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_timer/pages/main_page.dart';
import 'package:smart_timer/pages/page_404.dart';
import 'package:smart_timer/pages/splash_page.dart';
import 'package:smart_timer/pages/tabata_settings_page.dart';
import 'package:smart_timer/pages/timer_page.dart';
import 'package:smart_timer/routes/router_interface.dart';
import 'package:smart_timer/models/interval.dart' as interval;
import 'package:smart_timer/stores/timer_store.dart';

import 'main_route_path.dart';

class MainRouterDelegate extends RouterDelegate<MainRoutePath> with ChangeNotifier, PopNavigatorRouterDelegateMixin<MainRoutePath> implements RouterInterface {
  MainRouterDelegate(this.navigatorKey);

  @override
  MainRoutePath? currentConfiguration;

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  bool get hasMainScreenInside {
    final indexOfMain = currentConfiguration?.pages.indexWhere((element) => element.type == PageType.main);
    return indexOfMain != null && indexOfMain != -1;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('current router config: $currentConfiguration');
    if (currentConfiguration == null) {
      return Navigator(
        key: navigatorKey,
        pages: const [
          MaterialPage(
            key: ValueKey('SplashPage'),
            child: SplashPage(),
          )
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }
          return true;
        },
      );
    }

    final pages = <Page>[];
    for (var pageInfo in currentConfiguration!.pages) {
      final page = _selectPage(pageInfo);
      if (page == null) {
        // there is error in path. 404 should be shown
        pages.add(
          const MaterialPage(
            key: ValueKey('404Page'),
            child: Page404(),
          ),
        );
        break;
      }
      pages.add(page);
    }
    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        currentConfiguration?.pages.removeLast();
        return true;
      },
    );
  }

  MaterialPage? _selectPage(PageData pageData) {
    switch (pageData.type) {
      case PageType.splash:
        return const MaterialPage(
          key: ValueKey('SplashPage'),
          child: SplashPage(),
        );

      case PageType.main:
        return const MaterialPage(
          key: ValueKey('MainPage'),
          child: MainPage(),
        );

      case PageType.tabataSettings:
        return MaterialPage(
          key: const ValueKey('TabataPage'),
          child: TabataSettingsPage(),
        );
      case PageType.tabataTimer:
        final data = pageData as TabataTimerPageData;
        return MaterialPage(
          key: const ValueKey('TabataTimer'),
          child: Provider<TimerState>(
            create: (ctx) => TimerState(data.schedule),
            child: TimerPage(),
          ),
        );

      case PageType.page404:
        return const MaterialPage(
          key: ValueKey('SplashPage'),
          child: Page404(),
        );
    }
  }

  @override
  Future<void> setNewRoutePath(MainRoutePath configuration) async {
    print('SET NEW ${configuration.toString()}');
    //currentConfiguration = configuration;
    //notifyListeners();
  }

  @override
  void showMainPage() {
    currentConfiguration = MainRoutePath.main();
    notifyListeners();
  }

  @override
  void showTabataSettings() {
    currentConfiguration?.pages.add(const TabataSettigsPageData());
    notifyListeners();
  }

  @override
  void showTabataTimer(List<interval.Interval> schedule) {
    currentConfiguration?.pages.add(TabataTimerPageData(schedule));
    notifyListeners();
  }
}
