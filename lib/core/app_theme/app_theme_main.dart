import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'custom_color_scheme.dart';

class AppThemeMain implements AppTheme {
  final maintextTheme = ThemeData.dark().textTheme.apply(
        fontFamily: 'Inter',
        bodyColor: Colors.white,
        displayColor: Colors.white,
        decorationColor: Colors.white,
      );

  @override
  TextTheme get textTheme => maintextTheme.copyWith(
        bodyText1: maintextTheme.bodyText1?.copyWith(
          height: 19 / 15,
          fontSize: 15,
        ),
        bodyText2: maintextTheme.bodyText1?.copyWith(
          height: 20 / 14,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        subtitle1: const TextStyle(
          height: 19 / 15,
          fontSize: 15,
        ),
        subtitle2: const TextStyle(
          height: 15 / 15,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        headline1: maintextTheme.headline1?.copyWith(
          height: 47 / 60,
          fontSize: 60,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w900,
        ),
        headline2: const TextStyle(
          height: 22 / 18,
          fontSize: 18,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w900,
        ),
        headline3: const TextStyle(
          height: 24 / 17,
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
        headline4: const TextStyle(
          height: 19 / 15,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        headline6: const TextStyle(
          height: 16 / 16,
          fontSize: 16,
        ),
        button: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      );

  @override
  CustomColorScheme get colorScheme => const CustomColorScheme(
        brightness: Brightness.dark,
        primary: Colors.white,
        primaryVariant: Color(0xFF252527),
        primaryLight: Color(0x4C0354F1),
        secondary: Color(0xFFFE3125),
        secondaryVariant: Color(0xFFFFECEB),
        background: Colors.black,
        surface: Color(0xFFEEF4FF),
        onBackground: Colors.white,
        onSurface: Color(0xFF3E3E3E),
        onError: Color.fromARGB(89, 255, 46, 46),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        error: Color(0xFFED441F),
        accent: Color(0xFF32CC8F),
        amrapColor: Color(0xFF254CB0),
        afapColor: Color(0xFF387722),
        emomColor: Color(0xFF8F3A90),
        tabataColor: Color(0xFFC9791C),
        workRestColor: Color(0xFF239C9C),
        customColor: Color(0xFFCC4040),
      );

  @override
  ThemeData get themeData => ThemeData.from(
        colorScheme: colorScheme,
        textTheme: textTheme,
      ).copyWith(
        primaryColorBrightness: Brightness.light,
        highlightColor: Colors.white.withOpacity(.25),
        splashColor: Colors.white.withOpacity(.25),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          toolbarHeight: 90,
          titleSpacing: 36,
          foregroundColor: colorScheme.primary,
          titleTextStyle: TextStyle(
            fontSize: 24,
            height: 30 / 24,
            fontWeight: FontWeight.w900,
            fontFamily: 'ApercuPro',
            color: colorScheme.primary,
          ),
        ),
        bottomAppBarColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return colorScheme.primaryLight;
                  }
                  return colorScheme.primaryVariant;
                },
              ),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              textStyle: MaterialStateProperty.all(
                const TextStyle(fontSize: 18, fontFamily: 'ApercuPro'),
              ),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              minimumSize: MaterialStateProperty.all(const Size(double.infinity, 56))),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 15, fontFamily: 'ApercuPro'),
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 0)),
          ),
        ),
        dividerColor: colorScheme.primaryLight,
      );
}
