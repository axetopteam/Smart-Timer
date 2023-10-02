// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
    TabataRoute.name: (routeData) {
      final args = routeData.argsAs<TabataRouteArgs>(
          orElse: () => const TabataRouteArgs());
      return AutoRoutePage<void>(
        routeData: routeData,
        child: TabataPage(
          tabataSettings: args.tabataSettings,
          key: args.key,
        ),
      );
    },
    WorkRestRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WorkRestPage(),
      );
    },
    AfapRoute.name: (routeData) {
      final args =
          routeData.argsAs<AfapRouteArgs>(orElse: () => const AfapRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AfapPage(
          afapSettings: args.afapSettings,
          key: args.key,
        ),
      );
    },
    AmrapRoute.name: (routeData) {
      final args = routeData.argsAs<AmrapRouteArgs>(
          orElse: () => const AmrapRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AmrapPage(
          amrapSettings: args.amrapSettings,
          key: args.key,
        ),
      );
    },
    EmomRoute.name: (routeData) {
      final args =
          routeData.argsAs<EmomRouteArgs>(orElse: () => const EmomRouteArgs());
      return AutoRoutePage<void>(
        routeData: routeData,
        child: EmomPage(
          emomSettings: args.emomSettings,
          key: args.key,
        ),
      );
    },
    TimerRoute.name: (routeData) {
      final args = routeData.argsAs<TimerRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TimerPage(
          args.state,
          key: args.key,
        ),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    FavouritesRoute.name: (routeData) {
      return AutoRoutePage<void>(
        routeData: routeData,
        child: const FavouritesPage(),
      );
    },
  };
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TabataPage]
class TabataRoute extends PageRouteInfo<TabataRouteArgs> {
  TabataRoute({
    TabataSettings? tabataSettings,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          TabataRoute.name,
          args: TabataRouteArgs(
            tabataSettings: tabataSettings,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'TabataRoute';

  static const PageInfo<TabataRouteArgs> page = PageInfo<TabataRouteArgs>(name);
}

class TabataRouteArgs {
  const TabataRouteArgs({
    this.tabataSettings,
    this.key,
  });

  final TabataSettings? tabataSettings;

  final Key? key;

  @override
  String toString() {
    return 'TabataRouteArgs{tabataSettings: $tabataSettings, key: $key}';
  }
}

/// generated route for
/// [WorkRestPage]
class WorkRestRoute extends PageRouteInfo<void> {
  const WorkRestRoute({List<PageRouteInfo>? children})
      : super(
          WorkRestRoute.name,
          initialChildren: children,
        );

  static const String name = 'WorkRestRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AfapPage]
class AfapRoute extends PageRouteInfo<AfapRouteArgs> {
  AfapRoute({
    AfapSettings? afapSettings,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AfapRoute.name,
          args: AfapRouteArgs(
            afapSettings: afapSettings,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AfapRoute';

  static const PageInfo<AfapRouteArgs> page = PageInfo<AfapRouteArgs>(name);
}

class AfapRouteArgs {
  const AfapRouteArgs({
    this.afapSettings,
    this.key,
  });

  final AfapSettings? afapSettings;

  final Key? key;

  @override
  String toString() {
    return 'AfapRouteArgs{afapSettings: $afapSettings, key: $key}';
  }
}

/// generated route for
/// [AmrapPage]
class AmrapRoute extends PageRouteInfo<AmrapRouteArgs> {
  AmrapRoute({
    AmrapSettings? amrapSettings,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AmrapRoute.name,
          args: AmrapRouteArgs(
            amrapSettings: amrapSettings,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AmrapRoute';

  static const PageInfo<AmrapRouteArgs> page = PageInfo<AmrapRouteArgs>(name);
}

class AmrapRouteArgs {
  const AmrapRouteArgs({
    this.amrapSettings,
    this.key,
  });

  final AmrapSettings? amrapSettings;

  final Key? key;

  @override
  String toString() {
    return 'AmrapRouteArgs{amrapSettings: $amrapSettings, key: $key}';
  }
}

/// generated route for
/// [EmomPage]
class EmomRoute extends PageRouteInfo<EmomRouteArgs> {
  EmomRoute({
    EmomSettings? emomSettings,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          EmomRoute.name,
          args: EmomRouteArgs(
            emomSettings: emomSettings,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'EmomRoute';

  static const PageInfo<EmomRouteArgs> page = PageInfo<EmomRouteArgs>(name);
}

class EmomRouteArgs {
  const EmomRouteArgs({
    this.emomSettings,
    this.key,
  });

  final EmomSettings? emomSettings;

  final Key? key;

  @override
  String toString() {
    return 'EmomRouteArgs{emomSettings: $emomSettings, key: $key}';
  }
}

/// generated route for
/// [TimerPage]
class TimerRoute extends PageRouteInfo<TimerRouteArgs> {
  TimerRoute({
    required TimerState state,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          TimerRoute.name,
          args: TimerRouteArgs(
            state: state,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'TimerRoute';

  static const PageInfo<TimerRouteArgs> page = PageInfo<TimerRouteArgs>(name);
}

class TimerRouteArgs {
  const TimerRouteArgs({
    required this.state,
    this.key,
  });

  final TimerState state;

  final Key? key;

  @override
  String toString() {
    return 'TimerRouteArgs{state: $state, key: $key}';
  }
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavouritesPage]
class FavouritesRoute extends PageRouteInfo<void> {
  const FavouritesRoute({List<PageRouteInfo>? children})
      : super(
          FavouritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavouritesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
