import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_timer/purchasing/purchase_manager.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:uuid/uuid.dart';

import 'analytics/analytics_manager.dart';
import 'core/app_theme/theme.dart';
import 'firebase_options.dart';
import 'purchasing/premium_state.dart';

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

  final premiumState = PremiumState();
  PurchaseManager().initialize(onProfileUpdated: premiumState.updatePremiumStatus);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MyApp(appRouter),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp(this.appRouter, {Key? key}) : super(key: key);

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: createDarkTheme(),
    );
  }
}
