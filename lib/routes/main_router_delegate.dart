import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_timer/models/workout_set.dart';
// import 'package:smart_timer/models/workout.dart';
import 'package:smart_timer/pages/afap_page.dart';
import 'package:smart_timer/pages/amrap_page.dart';
import 'package:smart_timer/pages/custom_settings_page.dart';
import 'package:smart_timer/pages/emom_page.dart';
import 'package:smart_timer/pages/main_page.dart';
import 'package:smart_timer/pages/page_404.dart';
import 'package:smart_timer/pages/splash_page.dart';
import 'package:smart_timer/pages/tabata_page.dart';
import 'package:smart_timer/pages/timer_page.dart';
import 'package:smart_timer/routes/router_interface.dart';
import 'package:smart_timer/stores/timer.dart';

import 'main_route_path.dart';

class MainRouterDelegate extends RouterDelegate<MainRoutePath> with ChangeNotifier, PopNavigatorRouterDelegateMixin<MainRoutePath> implements RouterInterface {
  MainRouterDelegate(this.navigatorKey);

  @override
  MainRoutePath? currentConfiguration;

  @override
  final GlobalKey<NavigatorState> navigatorKey;

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

      case PageType.tabata:
        return const MaterialPage(
          key: ValueKey('TabataPage'),
          child: TabataPage(),
        );

      case PageType.emom:
        return MaterialPage(
          key: const ValueKey('EmomPage'),
          child: EmomPage(),
        );

      case PageType.amrap:
        return MaterialPage(
          key: const ValueKey('AmrapPage'),
          child: AmrapPage(),
        );

      case PageType.afap:
        return MaterialPage(
          key: const ValueKey('AfapPage'),
          child: AfapPage(),
        );

      case PageType.customSettings:
        return const MaterialPage(
          key: ValueKey('CustomSettingsPage'),
          child: CustomSettingsPage(),
        );

      case PageType.timer:
        final data = pageData as TimerPageData;
        return MaterialPage(
          key: const ValueKey('TimerPage'),
          child: Provider<Timer>(
            create: (ctx) => Timer(data.workout),
            dispose: (ctx, state) => state.close(),
            child: const TimerPage(),
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
    debugPrint('SET NEW ${configuration.toString()}');
    //currentConfiguration = configuration;
    //notifyListeners();
  }

  @override
  void showMainPage() {
    currentConfiguration = MainRoutePath.main();
    notifyListeners();
  }

  @override
  void showTabata() {
    currentConfiguration?.pages.add(const TabataPageData());
    notifyListeners();
  }

  @override
  void showEmom() {
    currentConfiguration?.pages.add(const EmomPageData());
    notifyListeners();
  }

  @override
  void showAmrap() {
    currentConfiguration?.pages.add(const AmrapPageData());
    notifyListeners();
  }

  @override
  void showAfap() {
    currentConfiguration?.pages.add(const AfapPageData());
    notifyListeners();
  }

  @override
  void showCustomSettings() {
    currentConfiguration?.pages.add(const CustomSettingsPageData());
    notifyListeners();
  }

  @override
  void showTimer(WorkoutSet workout) {
    currentConfiguration?.pages.add(TimerPageData(workout));
    notifyListeners();
  }
}
