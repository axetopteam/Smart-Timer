part of 'theme.dart';

class ThemeTextStyles extends ThemeExtension<ThemeTextStyles> {
  const ThemeTextStyles({
    required this.chip,
    required this.alternativeBodyLarge,
  });

  final TextStyle chip;
  final TextStyle alternativeBodyLarge;

  @override
  ThemeExtension<ThemeTextStyles> copyWith({TextStyle? chip, alternativeBodyLarge}) {
    return ThemeTextStyles(
      chip: chip ?? this.chip,
      alternativeBodyLarge: alternativeBodyLarge ?? this.alternativeBodyLarge,
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
    );
  }

  static get dark => const ThemeTextStyles(
        chip: AppFonts.chip,
        alternativeBodyLarge: AppFonts.alternativeBodyLarge,
      );
}
