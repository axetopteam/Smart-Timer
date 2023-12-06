part of 'theme.dart';

class ThemeTextStyles extends ThemeExtension<ThemeTextStyles> {
  const ThemeTextStyles({
    required this.chip,
    required this.alternativeBodyLarge,
    required this.cupertinoSectionTitle,
    required this.timerInfo,
    required this.footer,
  });

  final TextStyle chip;
  final TextStyle alternativeBodyLarge;
  final TextStyle cupertinoSectionTitle;
  final TextStyle timerInfo;
  final TextStyle footer;

  @override
  ThemeExtension<ThemeTextStyles> copyWith({
    TextStyle? chip,
    TextStyle? alternativeBodyLarge,
    TextStyle? cupertinoSectionTitle,
    TextStyle? timerInfo,
    TextStyle? footer,
  }) {
    return ThemeTextStyles(
      chip: chip ?? this.chip,
      alternativeBodyLarge: alternativeBodyLarge ?? this.alternativeBodyLarge,
      cupertinoSectionTitle: cupertinoSectionTitle ?? this.cupertinoSectionTitle,
      timerInfo: timerInfo ?? this.timerInfo,
      footer: footer ?? this.footer,
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
      timerInfo: TextStyle.lerp(timerInfo, other.timerInfo, t)!,
      footer: TextStyle.lerp(footer, other.footer, t)!,
    );
  }

  static get dark => const ThemeTextStyles(
        chip: AppFonts.chip,
        alternativeBodyLarge: AppFonts.alternativeBodyLarge,
        cupertinoSectionTitle: AppFonts.cupertinoSectionTitle,
        timerInfo: AppFonts.timerInfo,
        footer: AppFonts.footer,
      );
}
