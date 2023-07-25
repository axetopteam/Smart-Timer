import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_timer/purchasing/purchase_manager.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:uuid/uuid.dart';

import 'analytics/analytics_manager.dart';
import 'core/app_theme/theme.dart';
import 'firebase_options.dart';
import 'purchasing/adapty_profile_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  await EasyLocalization.ensureInitialized();

  final appProperties = AppProperties();
  await appProperties.initializeProperties();

  final appRouter = AppRouter();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );

  await AnalyticsManager().initialize();

  if (appProperties.firstLaunchDate == null) {
    appProperties.setFirstLaunchDate(DateTime.now());
    AnalyticsManager.eventFirstLaunch.commit();
  }

  if (appProperties.userId == null) {
    try {
      final uuid = const Uuid().v1();
      await appProperties.setUserId(uuid);
    } catch (e) {
      if (kDebugMode) {
        print('#main# Failed to get uuid');
      }
    }
  }

  await AnalyticsManager().setUserId(appProperties.userId);

  final adaptyProfileState = AdaptyProfileState();
  PurchaseManager().initialize(onProfileUpdated: adaptyProfileState.updatePremiumStatus);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: Provider.value(
        value: adaptyProfileState,
        child: MyApp(appRouter),
      ),
    ),
  );
}

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
      case AppLifecycleState.inactive:
        AnalyticsManager.eventAppClosed.commit();
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
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
