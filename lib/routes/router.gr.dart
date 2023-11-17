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
    NewTimerRoute.name: (routeData) {
      return AutoRoutePage<void>(
        routeData: routeData,
        child: const NewTimerPage(),
      );
    },
    NewTimerRouter.name: (routeData) {
      return AutoRoutePage<void>(
        routeData: routeData,
        child: const NewTimerNavigator(),
      );
    },
    TabataRoute.name: (routeData) {
      final args = routeData.argsAs<TabataRouteArgs>(orElse: () => const TabataRouteArgs());
      return AutoRoutePage<void>(
        routeData: routeData,
        child: TabataPage(
          tabataSettings: args.tabataSettings,
          key: args.key,
        ),
      );
    },
    WorkRestRoute.name: (routeData) {
      final args = routeData.argsAs<WorkRestRouteArgs>(orElse: () => const WorkRestRouteArgs());
      return AutoRoutePage<void>(
        routeData: routeData,
        child: WorkRestPage(
          workRestSettings: args.workRestSettings,
          key: args.key,
        ),
      );
    },
    AfapRoute.name: (routeData) {
      final args = routeData.argsAs<AfapRouteArgs>(orElse: () => const AfapRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AfapPage(
          afapSettings: args.afapSettings,
          key: args.key,
        ),
      );
    },
    AmrapRoute.name: (routeData) {
      final args = routeData.argsAs<AmrapRouteArgs>(orElse: () => const AmrapRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AmrapPage(
          amrapSettings: args.amrapSettings,
          key: args.key,
        ),
      );
    },
    EmomRoute.name: (routeData) {
      final args = routeData.argsAs<EmomRouteArgs>(orElse: () => const EmomRouteArgs());
      return AutoRoutePage<void>(
        routeData: routeData,
        child: EmomPage(
          emomSettings: args.emomSettings,
          key: args.key,
        ),
      );
    },
    FavouritesRoute.name: (routeData) {
      return AutoRoutePage<void>(
        routeData: routeData,
        child: const FavouritesPage(),
      );
    },
    TimerRoute.name: (routeData) {
      final args = routeData.argsAs<TimerRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TimerPage(
          timerSettings: args.timerSettings,
          key: args.key,
        ),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<void>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    HistoryRoute.name: (routeData) {
      return AutoRoutePage<void>(
        routeData: routeData,
        child: const HistoryPage(),
      );
    },
    WorkoutDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<WorkoutDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WorkoutDetailsPage(
          args.record,
          key: args.key,
        ),
      );
    },
    WorkoutsRouter.name: (routeData) {
      return AutoRoutePage<void>(
        routeData: routeData,
        child: const WorkoutsTab(),
      );
    },
    WorkoutsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WorkoutsPage(),
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
/// [NewTimerPage]
class NewTimerRoute extends PageRouteInfo<void> {
  const NewTimerRoute({List<PageRouteInfo>? children})
      : super(
          NewTimerRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewTimerRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NewTimerNavigator]
class NewTimerRouter extends PageRouteInfo<void> {
  const NewTimerRouter({List<PageRouteInfo>? children})
      : super(
          NewTimerRouter.name,
          initialChildren: children,
        );

  static const String name = 'NewTimerRouter';

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
class WorkRestRoute extends PageRouteInfo<WorkRestRouteArgs> {
  WorkRestRoute({
    WorkRestSettings? workRestSettings,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          WorkRestRoute.name,
          args: WorkRestRouteArgs(
            workRestSettings: workRestSettings,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'WorkRestRoute';

  static const PageInfo<WorkRestRouteArgs> page = PageInfo<WorkRestRouteArgs>(name);
}

class WorkRestRouteArgs {
  const WorkRestRouteArgs({
    this.workRestSettings,
    this.key,
  });

  final WorkRestSettings? workRestSettings;

  final Key? key;

  @override
  String toString() {
    return 'WorkRestRouteArgs{workRestSettings: $workRestSettings, key: $key}';
  }
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

/// generated route for
/// [TimerPage]
class TimerRoute extends PageRouteInfo<TimerRouteArgs> {
  TimerRoute({
    required TimerSettingsInterface timerSettings,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          TimerRoute.name,
          args: TimerRouteArgs(
            timerSettings: timerSettings,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'TimerRoute';

  static const PageInfo<TimerRouteArgs> page = PageInfo<TimerRouteArgs>(name);
}

class TimerRouteArgs {
  const TimerRouteArgs({
    required this.timerSettings,
    this.key,
  });

  final TimerSettingsInterface timerSettings;

  final Key? key;

  @override
  String toString() {
    return 'TimerRouteArgs{timerSettings: $timerSettings, key: $key}';
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
/// [HistoryPage]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute({List<PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WorkoutDetailsPage]
class WorkoutDetailsRoute extends PageRouteInfo<WorkoutDetailsRouteArgs> {
  WorkoutDetailsRoute({
    required TrainingHistoryRecord record,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          WorkoutDetailsRoute.name,
          args: WorkoutDetailsRouteArgs(
            record: record,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'WorkoutDetailsRoute';

  static const PageInfo<WorkoutDetailsRouteArgs> page = PageInfo<WorkoutDetailsRouteArgs>(name);
}

class WorkoutDetailsRouteArgs {
  const WorkoutDetailsRouteArgs({
    required this.record,
    this.key,
  });

  final TrainingHistoryRecord record;

  final Key? key;

  @override
  String toString() {
    return 'WorkoutDetailsRouteArgs{record: $record, key: $key}';
  }
}

/// generated route for
/// [WorkoutsTab]
class WorkoutsRouter extends PageRouteInfo<void> {
  const WorkoutsRouter({List<PageRouteInfo>? children})
      : super(
          WorkoutsRouter.name,
          initialChildren: children,
        );

  static const String name = 'WorkoutsRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WorkoutsPage]
class WorkoutsRoute extends PageRouteInfo<void> {
  const WorkoutsRoute({List<PageRouteInfo>? children})
      : super(
          WorkoutsRoute.name,
          initialChildren: children,
        );

  static const String name = 'WorkoutsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
