import 'package:flutter/material.dart';

class CustomColorScheme extends ColorScheme {
  const CustomColorScheme({
    required Color primary,
    required Color primaryVariant,
    required Color secondary,
    required Color secondaryVariant,
    required Color surface,
    required Color background,
    required Color error,
    required Color onPrimary,
    required Color onSecondary,
    required Color onSurface,
    required Color onBackground,
    required Color onError,
    required Brightness brightness,
    required this.amrapColor,
    required this.afapColor,
    required this.emomColor,
    required this.tabataColor,
    required this.workRestColor,
    required this.customColor,
    required this.primaryLight,
    required this.accent,
  }) : super(
          primary: primary,
          primaryVariant: primaryVariant,
          secondary: secondary,
          secondaryVariant: secondaryVariant,
          surface: surface,
          background: background,
          error: error,
          onPrimary: onPrimary,
          onSecondary: onSecondary,
          onSurface: onSurface,
          onBackground: onBackground,
          onError: onError,
          brightness: brightness,
        );

  final Color amrapColor;
  final Color afapColor;
  final Color emomColor;
  final Color tabataColor;
  final Color workRestColor;
  final Color customColor;

  final Color primaryLight;
  final Color accent;
}
