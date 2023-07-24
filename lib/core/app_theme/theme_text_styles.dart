part of 'theme.dart';

class ThemeTextStyles extends ThemeExtension<ThemeTextStyles> {
  const ThemeTextStyles();

  @override
  ThemeExtension<ThemeTextStyles> copyWith() {
    return const ThemeTextStyles();
  }

  @override
  ThemeExtension<ThemeTextStyles> lerp(
    ThemeExtension<ThemeTextStyles>? other,
    double t,
  ) {
    if (other is! ThemeTextStyles) {
      return this;
    }

    return const ThemeTextStyles();
  }

  static get dark => const ThemeTextStyles();
}
