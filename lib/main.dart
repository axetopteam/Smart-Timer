import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/services/app_properties.dart';

import 'core/app_theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appProperties = AppProperties();
  await appProperties.initializeProperties();

  GetIt.I.registerSingleton<AppProperties>(appProperties);
  final _appRouter = AppRouter();

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
      theme: createDarkTheme(),
    );
  }
}
