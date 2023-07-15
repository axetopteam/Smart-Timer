part of 'theme.dart';

class ThemeColors extends ThemeExtension<ThemeColors> {
  final Color amrapColor;
  final Color afapColor;
  final Color emomColor;
  final Color tabataColor;
  final Color workRestColor;
  final Color customColor;
  final Color mainText;
  final Color secondaryText;
  final Color tertiaryText;
  final Color borderColor;
  final Color bottomSheetBackgroundColor;
  final Color timerOverlayColor;
  final Color playIconColor;
  final Color pauseOverlayColor;
  final Color pickerOverlay;
  final Color background;
  final Color containerBackground;
  final Color premium;
  final Color warning;
  final Color accent;

  const ThemeColors({
    required this.amrapColor,
    required this.afapColor,
    required this.emomColor,
    required this.tabataColor,
    required this.workRestColor,
    required this.customColor,
    required this.mainText,
    required this.secondaryText,
    required this.tertiaryText,
    required this.borderColor,
    required this.bottomSheetBackgroundColor,
    required this.timerOverlayColor,
    required this.playIconColor,
    required this.pauseOverlayColor,
    required this.pickerOverlay,
    required this.background,
    required this.containerBackground,
    required this.premium,
    required this.warning,
    required this.accent,
  });

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? amrapColor,
    Color? afapColor,
    Color? emomColor,
    Color? tabataColor,
    Color? workRestColor,
    Color? customColor,
    Color? mainText,
    Color? secondaryText,
    Color? tertiaryText,
    Color? borderColor,
    Color? bottomSheetBackgroundColor,
    Color? timerOverlayColor,
    Color? playIconColor,
    Color? pauseOverlayColor,
    Color? pickerOverlay,
    Color? background,
    Color? containerBackground,
    Color? premium,
    Color? warning,
    Color? accent,
  }) {
    return ThemeColors(
      amrapColor: amrapColor ?? this.amrapColor,
      afapColor: afapColor ?? this.afapColor,
      emomColor: emomColor ?? this.emomColor,
      tabataColor: tabataColor ?? this.tabataColor,
      workRestColor: workRestColor ?? this.workRestColor,
      customColor: customColor ?? this.customColor,
      mainText: mainText ?? this.mainText,
      secondaryText: secondaryText ?? this.secondaryText,
      tertiaryText: tertiaryText ?? this.tertiaryText,
      borderColor: borderColor ?? this.borderColor,
      bottomSheetBackgroundColor: bottomSheetBackgroundColor ?? this.bottomSheetBackgroundColor,
      timerOverlayColor: timerOverlayColor ?? this.timerOverlayColor,
      playIconColor: playIconColor ?? this.playIconColor,
      pauseOverlayColor: pauseOverlayColor ?? this.pauseOverlayColor,
      pickerOverlay: pickerOverlay ?? this.pickerOverlay,
      background: background ?? this.background,
      containerBackground: containerBackground ?? this.containerBackground,
      premium: premium ?? this.premium,
      warning: warning ?? this.warning,
      accent: accent ?? this.accent,
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
      afapColor: Color.lerp(afapColor, other.afapColor, t)!,
      emomColor: Color.lerp(emomColor, other.emomColor, t)!,
      tabataColor: Color.lerp(tabataColor, other.tabataColor, t)!,
      workRestColor: Color.lerp(workRestColor, other.workRestColor, t)!,
      customColor: Color.lerp(customColor, other.customColor, t)!,
      mainText: Color.lerp(mainText, other.mainText, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      tertiaryText: Color.lerp(tertiaryText, other.tertiaryText, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      bottomSheetBackgroundColor: Color.lerp(bottomSheetBackgroundColor, other.bottomSheetBackgroundColor, t)!,
      timerOverlayColor: Color.lerp(timerOverlayColor, other.timerOverlayColor, t)!,
      playIconColor: Color.lerp(playIconColor, other.playIconColor, t)!,
      pauseOverlayColor: Color.lerp(pauseOverlayColor, other.pauseOverlayColor, t)!,
      pickerOverlay: Color.lerp(pickerOverlay, other.pickerOverlay, t)!,
      background: Color.lerp(background, other.background, t)!,
      containerBackground: Color.lerp(containerBackground, other.containerBackground, t)!,
      premium: Color.lerp(premium, other.premium, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
    );
  }

  static get dark => ThemeColors(
        amrapColor: AppColors.denimBlue,
        afapColor: AppColors.darkGreen,
        emomColor: AppColors.brightPurple,
        tabataColor: AppColors.ochre,
        workRestColor: AppColors.greenishBlue,
        customColor: AppColors.paleRed,
        mainText: AppColors.white,
        secondaryText: Colors.grey,
        tertiaryText: Colors.black87,
        borderColor: AppColors.grey,
        bottomSheetBackgroundColor: AppColors.black,
        timerOverlayColor: AppColors.black70,
        playIconColor: AppColors.white,
        pauseOverlayColor: AppColors.black50,
        pickerOverlay: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),
        background: AppColors.black,
        containerBackground: AppColors.greyBlue,
        premium: AppColors.activeGreen,
        warning: AppColors.systemRed,
        accent: AppColors.activeBlue,
      );
}
