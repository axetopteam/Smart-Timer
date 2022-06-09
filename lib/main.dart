import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/services/app_properties.dart';

import 'core/app_theme/app_theme.dart';
import 'core/app_theme/app_theme_main.dart';
import 'routes/main_auto_router.gr.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appProperties = AppProperties();
  await appProperties.initializeProperties();

  getIt.registerSingleton<AppProperties>(appProperties);
  GetIt.instance.registerSingleton<AppTheme>(AppThemeMain());
  final _appRouter = AppRouter();
  GetIt.instance.registerSingleton<AppRouter>(_appRouter);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(MyApp(_appRouter));
}

class MyApp extends StatelessWidget {
  const MyApp(this.appRouter, {Key? key}) : super(key: key);

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      title: 'Smart Timer',
      debugShowCheckedModeBanner: false,
      theme: GetIt.instance<AppTheme>().themeData,
    );
  }
}
