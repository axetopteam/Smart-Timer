import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../analytics/analytics_manager.dart';
import '../core/app_theme/theme.dart';
import '../routes/router.dart';
import '../services/app_properties.dart';

class MyApp extends StatefulWidget {
  const MyApp(this.appRouter, {Key? key}) : super(key: key);

  final AppRouter appRouter;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    AnalyticsManager.eventAppOpened.commit();
    if (AppProperties().introShowedAt == null) {
      widget.appRouter.push(const IntroRoute());
    } else {
      widget.appRouter.push(const MainRoute());
    }

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        AnalyticsManager.eventAppOpened.commit();
      case AppLifecycleState.paused:
        AnalyticsManager.eventAppClosed.commit();
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: widget.appRouter.delegate(),
      routeInformationParser: widget.appRouter.defaultRouteParser(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: createDarkTheme(),
    );
  }
}
