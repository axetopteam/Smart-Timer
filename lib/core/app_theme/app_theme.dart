import 'package:flutter/material.dart';

import 'custom_color_scheme.dart';

abstract class AppTheme {
  TextTheme get textTheme;
  CustomColorScheme get colorScheme;

  ThemeData get themeData;
}
