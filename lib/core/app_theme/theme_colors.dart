part of 'theme.dart';

class ThemeColors extends ThemeExtension<ThemeColors> {
  final Color amrapColor;
  final Color forTimeColor;
  final Color emomColor;
  final Color tabataColor;
  final Color workRestColor;
  final Color customColor;
  final Color borderColor;

  const ThemeColors({
    required this.amrapColor,
    required this.forTimeColor,
    required this.emomColor,
    required this.tabataColor,
    required this.workRestColor,
    required this.customColor,
    required this.borderColor,
  });

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? amrapColor,
    Color? forTimeColor,
    Color? emomColor,
    Color? tabataColor,
    Color? workRestColor,
    Color? customColor,
    Color? borderColor,
  }) {
    return ThemeColors(
      amrapColor: amrapColor ?? this.amrapColor,
      forTimeColor: forTimeColor ?? this.forTimeColor,
      emomColor: emomColor ?? this.emomColor,
      tabataColor: tabataColor ?? this.tabataColor,
      workRestColor: workRestColor ?? this.workRestColor,
      customColor: customColor ?? this.customColor,
      borderColor: borderColor ?? this.borderColor,
    );
  }

  @override
  ThemeExtension<ThemeColors> lerp(
    ThemeExtension<ThemeColors>? other,
    double t,
  ) {
    if (other is! ThemeColors) {
      return this;
    }

    return ThemeColors(
      amrapColor: Color.lerp(amrapColor, other.amrapColor, t)!,
      forTimeColor: Color.lerp(forTimeColor, other.forTimeColor, t)!,
      emomColor: Color.lerp(emomColor, other.emomColor, t)!,
      tabataColor: Color.lerp(tabataColor, other.tabataColor, t)!,
      workRestColor: Color.lerp(workRestColor, other.workRestColor, t)!,
      customColor: Color.lerp(customColor, other.customColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
    );
  }

  static get dark => const ThemeColors(
        amrapColor: AppColors.denimBlue,
        forTimeColor: AppColors.darkGreen,
        emomColor: AppColors.brightPurple,
        tabataColor: AppColors.ochre,
        workRestColor: AppColors.greenishBlue,
        customColor: AppColors.paleRed,
        borderColor: AppColors.grey,
      );
}
