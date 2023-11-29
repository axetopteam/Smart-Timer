part of 'theme.dart';

class ThemeTextStyles extends ThemeExtension<ThemeTextStyles> {
  const ThemeTextStyles({
    required this.chip,
    required this.alternativeBodyLarge,
    required this.cupertinoSectionTitle,
  });

  final TextStyle chip;
  final TextStyle alternativeBodyLarge;
  final TextStyle cupertinoSectionTitle;

  @override
  ThemeExtension<ThemeTextStyles> copyWith({
    TextStyle? chip,
    TextStyle? alternativeBodyLarge,
    TextStyle? cupertinoSectionTitle,
  }) {
    return ThemeTextStyles(
      chip: chip ?? this.chip,
      alternativeBodyLarge: alternativeBodyLarge ?? this.alternativeBodyLarge,
      cupertinoSectionTitle: cupertinoSectionTitle ?? this.cupertinoSectionTitle,
    );
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
      alternativeBodyLarge: TextStyle.lerp(alternativeBodyLarge, other.alternativeBodyLarge, t)!,
      cupertinoSectionTitle: TextStyle.lerp(cupertinoSectionTitle, other.cupertinoSectionTitle, t)!,
    );
  }

  static get dark => const ThemeTextStyles(
        chip: AppFonts.chip,
        alternativeBodyLarge: AppFonts.alternativeBodyLarge,
        cupertinoSectionTitle: AppFonts.cupertinoSectionTitle,
      );
}
