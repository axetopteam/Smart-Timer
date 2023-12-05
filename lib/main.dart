import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:smart_timer/purchasing/purchase_manager.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/sdk/db/database.dart';
import 'package:smart_timer/sdk/sdk_service.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:uuid/uuid.dart';

import 'UI/my_app.dart';
import 'analytics/analytics_manager.dart';
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

  GetIt.I.registerSingleton(SdkService(db: AppDatabase()));

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
