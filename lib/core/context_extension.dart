import 'package:flutter/material.dart';

import 'app_theme/theme.dart';

extension BuildContextExt on BuildContext {
  // ThemeTextStyles get text => Theme.of(this).extension<ThemeTextStyles>()!;

  ThemeColors get color => Theme.of(this).extension<ThemeColors>()!;

  TextTheme get textTheme => Theme.of(this).textTheme;

  ThemeButtonStyles get buttonThemes => Theme.of(this).extension<ThemeButtonStyles>()!;
}
