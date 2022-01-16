import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/routes/main_route_information_parser.dart';
import 'package:smart_timer/routes/main_router_delegate.dart';
import 'package:smart_timer/routes/router_interface.dart';
import 'package:smart_timer/services/app_properties.dart';

import 'core/app_theme/app_theme.dart';
import 'core/app_theme/app_theme_main.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final router = MainRouterDelegate(GlobalKey<NavigatorState>());
  final appProperties = AppProperties();
  await appProperties.initializeProperties();

  getIt.registerSingleton<RouterInterface>(router);
  getIt.registerSingleton<AppProperties>(appProperties);
  GetIt.instance.registerSingleton<AppTheme>(AppThemeMain());

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(MyApp(router));
}

class MyApp extends StatelessWidget {
  MyApp(this.router, {Key? key}) : super(key: key) {
    router.showMainPage();
  }

  final MainRouterDelegate router;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: MainRouteInformationParser(),
      routerDelegate: router,
      title: 'Smart Timer',
      debugShowCheckedModeBanner: false,
      theme: GetIt.instance<AppTheme>().themeData,
    );
  }
}
