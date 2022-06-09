// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../models/workout_set.dart' as _i11;
import '../pages/afap_page.dart' as _i3;
import '../pages/amrap_page.dart' as _i2;
import '../pages/custom_settings_page.dart' as _i7;
import '../pages/emom_page.dart' as _i4;
import '../pages/main_page.dart' as _i1;
import '../pages/tabata_page.dart' as _i5;
import '../pages/timer_page.dart' as _i8;
import '../pages/work_rest_page.dart' as _i6;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.MainPage());
    },
    AmrapRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.AmrapPage());
    },
    AfapRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.AfapPage());
    },
    EmomRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.EmomPage());
    },
    TabataRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.TabataPage());
    },
    WorkRestRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.WorkRestPage());
    },
    CustomSettingsRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.CustomSettingsPage());
    },
    TimerRoute.name: (routeData) {
      final args = routeData.argsAs<TimerRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i8.TimerPage(args.workout, key: args.key));
    }
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(MainRoute.name, path: '/'),
        _i9.RouteConfig(AmrapRoute.name, path: '/amrap-page'),
        _i9.RouteConfig(AfapRoute.name, path: '/afap-page'),
        _i9.RouteConfig(EmomRoute.name, path: '/emom-page'),
        _i9.RouteConfig(TabataRoute.name, path: '/tabata-page'),
        _i9.RouteConfig(WorkRestRoute.name, path: '/work-rest-page'),
        _i9.RouteConfig(CustomSettingsRoute.name,
            path: '/custom-settings-page'),
        _i9.RouteConfig(TimerRoute.name, path: '/timer-page')
      ];
}

/// generated route for
/// [_i1.MainPage]
class MainRoute extends _i9.PageRouteInfo<void> {
  const MainRoute() : super(MainRoute.name, path: '/');

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i2.AmrapPage]
class AmrapRoute extends _i9.PageRouteInfo<void> {
  const AmrapRoute() : super(AmrapRoute.name, path: '/amrap-page');

  static const String name = 'AmrapRoute';
}

/// generated route for
/// [_i3.AfapPage]
class AfapRoute extends _i9.PageRouteInfo<void> {
  const AfapRoute() : super(AfapRoute.name, path: '/afap-page');

  static const String name = 'AfapRoute';
}

/// generated route for
/// [_i4.EmomPage]
class EmomRoute extends _i9.PageRouteInfo<void> {
  const EmomRoute() : super(EmomRoute.name, path: '/emom-page');

  static const String name = 'EmomRoute';
}

/// generated route for
/// [_i5.TabataPage]
class TabataRoute extends _i9.PageRouteInfo<void> {
  const TabataRoute() : super(TabataRoute.name, path: '/tabata-page');

  static const String name = 'TabataRoute';
}

/// generated route for
/// [_i6.WorkRestPage]
class WorkRestRoute extends _i9.PageRouteInfo<void> {
  const WorkRestRoute() : super(WorkRestRoute.name, path: '/work-rest-page');

  static const String name = 'WorkRestRoute';
}

/// generated route for
/// [_i7.CustomSettingsPage]
class CustomSettingsRoute extends _i9.PageRouteInfo<void> {
  const CustomSettingsRoute()
      : super(CustomSettingsRoute.name, path: '/custom-settings-page');

  static const String name = 'CustomSettingsRoute';
}

/// generated route for
/// [_i8.TimerPage]
class TimerRoute extends _i9.PageRouteInfo<TimerRouteArgs> {
  TimerRoute({required _i11.WorkoutSet workout, _i10.Key? key})
      : super(TimerRoute.name,
            path: '/timer-page',
            args: TimerRouteArgs(workout: workout, key: key));

  static const String name = 'TimerRoute';
}

class TimerRouteArgs {
  const TimerRouteArgs({required this.workout, this.key});

  final _i11.WorkoutSet workout;

  final _i10.Key? key;

  @override
  String toString() {
    return 'TimerRouteArgs{workout: $workout, key: $key}';
  }
}
