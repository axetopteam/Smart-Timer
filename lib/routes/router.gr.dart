// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const MainPage());
    },
    AmrapRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const AmrapPage());
    },
    AfapRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const AfapPage());
    },
    EmomRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmomPage());
    },
    TabataRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const TabataPage());
    },
    WorkRestRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const WorkRestPage());
    },
    CustomizedRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const CustomizedPage());
    },
    TimerRoute.name: (routeData) {
      final args = routeData.argsAs<TimerRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData, child: TimerPage(args.state, key: args.key));
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(MainRoute.name, path: '/'),
        RouteConfig(AmrapRoute.name, path: '/amrap-page'),
        RouteConfig(AfapRoute.name, path: '/afap-page'),
        RouteConfig(EmomRoute.name, path: '/emom-page'),
        RouteConfig(TabataRoute.name, path: '/tabata-page'),
        RouteConfig(WorkRestRoute.name, path: '/work-rest-page'),
        RouteConfig(CustomizedRoute.name, path: '/customized-page'),
        RouteConfig(TimerRoute.name, path: '/timer-page')
      ];
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute() : super(MainRoute.name, path: '/');

  static const String name = 'MainRoute';
}

/// generated route for
/// [AmrapPage]
class AmrapRoute extends PageRouteInfo<void> {
  const AmrapRoute() : super(AmrapRoute.name, path: '/amrap-page');

  static const String name = 'AmrapRoute';
}

/// generated route for
/// [AfapPage]
class AfapRoute extends PageRouteInfo<void> {
  const AfapRoute() : super(AfapRoute.name, path: '/afap-page');

  static const String name = 'AfapRoute';
}

/// generated route for
/// [EmomPage]
class EmomRoute extends PageRouteInfo<void> {
  const EmomRoute() : super(EmomRoute.name, path: '/emom-page');

  static const String name = 'EmomRoute';
}

/// generated route for
/// [TabataPage]
class TabataRoute extends PageRouteInfo<void> {
  const TabataRoute() : super(TabataRoute.name, path: '/tabata-page');

  static const String name = 'TabataRoute';
}

/// generated route for
/// [WorkRestPage]
class WorkRestRoute extends PageRouteInfo<void> {
  const WorkRestRoute() : super(WorkRestRoute.name, path: '/work-rest-page');

  static const String name = 'WorkRestRoute';
}

/// generated route for
/// [CustomizedPage]
class CustomizedRoute extends PageRouteInfo<void> {
  const CustomizedRoute()
      : super(CustomizedRoute.name, path: '/customized-page');

  static const String name = 'CustomizedRoute';
}

/// generated route for
/// [TimerPage]
class TimerRoute extends PageRouteInfo<TimerRouteArgs> {
  TimerRoute({required TimerState state, Key? key})
      : super(TimerRoute.name,
            path: '/timer-page', args: TimerRouteArgs(state: state, key: key));

  static const String name = 'TimerRoute';
}

class TimerRouteArgs {
  const TimerRouteArgs({required this.state, this.key});

  final TimerState state;

  final Key? key;

  @override
  String toString() {
    return 'TimerRouteArgs{state: $state, key: $key}';
  }
}
