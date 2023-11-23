part of 'theme.dart';

class ThemeTextStyles extends ThemeExtension<ThemeTextStyles> {
  const ThemeTextStyles({
    required this.chip,
  });

  final TextStyle chip;

  @override
  ThemeExtension<ThemeTextStyles> copyWith({
    TextStyle? chip,
  }) {
    return ThemeTextStyles(chip: chip ?? this.chip);
  }

  @override
  ThemeExtension<ThemeTextStyles> lerp(
    ThemeExtension<ThemeTextStyles>? other,
    double t,
  ) {
    if (other is! ThemeTextStyles) {
      return this;
    }

    return ThemeTextStyles(
      chip: TextStyle.lerp(chip, other.chip, t)!,
    );
  }

  static get dark => const ThemeTextStyles(chip: AppFonts.chip);
}
