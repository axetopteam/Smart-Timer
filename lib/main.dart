import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/routes/main_route_information_parser.dart';
import 'package:smart_timer/routes/main_router_delegate.dart';
import 'package:smart_timer/routes/router_interface.dart';

GetIt getIt = GetIt.instance;

void main() {
  final router = MainRouterDelegate(GlobalKey<NavigatorState>());
  getIt.registerSingleton<RouterInterface>(router);
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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        primaryColor: AppColors.accentBlue,
        canvasColor: AppColors.backgroundColor,
        appBarTheme: const AppBarTheme(
          foregroundColor: AppColors.accentBlue,
        ),
      ),
    );
  }
}
