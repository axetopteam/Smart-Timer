part of 'theme.dart';

class ThemeColors extends ThemeExtension<ThemeColors> {
  final Color amrapColor;
  final Color forTimeColor;
  final Color emomColor;
  final Color tabataColor;
  final Color workRestColor;
  final Color customColor;
  final Color borderColor;
  final Color bottomSheetBackgroundColor;
  final Color timerOverlayColor;
  final Color playIconColor;
  final Color pauseOverlayColor;

  const ThemeColors({
    required this.amrapColor,
    required this.forTimeColor,
    required this.emomColor,
    required this.tabataColor,
    required this.workRestColor,
    required this.customColor,
    required this.borderColor,
    required this.bottomSheetBackgroundColor,
    required this.timerOverlayColor,
    required this.playIconColor,
    required this.pauseOverlayColor,
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
    Color? bottomSheetBackgroundColor,
    Color? timerOverlayColor,
    Color? playIconColor,
    Color? pauseOverlayColor,
  }) {
    return ThemeColors(
      amrapColor: amrapColor ?? this.amrapColor,
      forTimeColor: forTimeColor ?? this.forTimeColor,
      emomColor: emomColor ?? this.emomColor,
      tabataColor: tabataColor ?? this.tabataColor,
      workRestColor: workRestColor ?? this.workRestColor,
      customColor: customColor ?? this.customColor,
      borderColor: borderColor ?? this.borderColor,
      bottomSheetBackgroundColor: bottomSheetBackgroundColor ?? this.bottomSheetBackgroundColor,
      timerOverlayColor: timerOverlayColor ?? this.timerOverlayColor,
      playIconColor: playIconColor ?? this.playIconColor,
      pauseOverlayColor: pauseOverlayColor ?? this.pauseOverlayColor,
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
      bottomSheetBackgroundColor: Color.lerp(bottomSheetBackgroundColor, other.bottomSheetBackgroundColor, t)!,
      timerOverlayColor: Color.lerp(timerOverlayColor, other.timerOverlayColor, t)!,
      playIconColor: Color.lerp(playIconColor, other.playIconColor, t)!,
      pauseOverlayColor: Color.lerp(pauseOverlayColor, other.pauseOverlayColor, t)!,
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
        bottomSheetBackgroundColor: AppColors.black,
        timerOverlayColor: AppColors.black70,
        playIconColor: AppColors.white,
        pauseOverlayColor: AppColors.black50,
      );
}
