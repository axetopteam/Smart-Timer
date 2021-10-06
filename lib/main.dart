import 'package:flutter/material.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/pages/main_page.dart';

import 'pages/timer_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        primaryColor: AppColors.accentBlue,
        canvasColor: AppColors.backgroundColor,
        appBarTheme: const AppBarTheme(
          foregroundColor: AppColors.accentBlue,
        ),
      ),
      home: const MainPage(),
    );
  }
}
