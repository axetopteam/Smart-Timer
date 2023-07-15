part of 'theme.dart';

class ThemeButtonStyles extends ThemeExtension<ThemeButtonStyles> {
  final ElevatedButtonThemeData startButtonTheme;
  final TextButtonThemeData deleteButtonTheme;
  final ElevatedButtonThemeData popupButtonTheme;
  final ElevatedButtonThemeData paywallButtonTheme;

  const ThemeButtonStyles({
    required this.startButtonTheme,
    required this.deleteButtonTheme,
    required this.popupButtonTheme,
    required this.paywallButtonTheme,
  });

  @override
  ThemeExtension<ThemeButtonStyles> copyWith({
    ElevatedButtonThemeData? startButtonTheme,
    TextButtonThemeData? deleteButtonTheme,
    ElevatedButtonThemeData? popupButtonTheme,
    ElevatedButtonThemeData? paywallButtonTheme,
  }) {
    return ThemeButtonStyles(
      startButtonTheme: startButtonTheme ?? this.startButtonTheme,
      deleteButtonTheme: deleteButtonTheme ?? this.deleteButtonTheme,
      popupButtonTheme: popupButtonTheme ?? this.popupButtonTheme,
      paywallButtonTheme: paywallButtonTheme ?? this.paywallButtonTheme,
    );
  }

  @override
  ThemeExtension<ThemeButtonStyles> lerp(
    ThemeExtension<ThemeButtonStyles>? other,
    double t,
  ) {
    if (other is! ThemeButtonStyles) {
      return this;
    }

    return ThemeButtonStyles(
      startButtonTheme: ElevatedButtonThemeData.lerp(startButtonTheme, other.startButtonTheme, t)!,
      deleteButtonTheme: TextButtonThemeData.lerp(deleteButtonTheme, other.deleteButtonTheme, t)!,
      popupButtonTheme: ElevatedButtonThemeData.lerp(popupButtonTheme, other.popupButtonTheme, t)!,
      paywallButtonTheme: ElevatedButtonThemeData.lerp(paywallButtonTheme, other.paywallButtonTheme, t)!,
    );
  }

  static get dark => ThemeButtonStyles(
        startButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(AppColors.white),
            textStyle: MaterialStateProperty.all(displayMedium),
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            fixedSize: MaterialStateProperty.all(const Size(130, 56)),
          ),
        ),
        deleteButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              foregroundColor: MaterialStateProperty.all(AppColors.red),
              textStyle: MaterialStateProperty.all(bodyMedium),
              minimumSize: MaterialStateProperty.all(const Size(0, 24)),
              overlayColor: MaterialStateProperty.all(Colors.transparent)),
        ),
        popupButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(AppColors.black),
            backgroundColor: MaterialStateProperty.all(AppColors.white),
            textStyle: MaterialStateProperty.all(displayMedium),
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            minimumSize: MaterialStateProperty.all(const Size(double.infinity, 56)),
          ),
        ),
        paywallButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(AppColors.white),
            backgroundColor: MaterialStateProperty.all(AppColors.activeBlue),
            textStyle: MaterialStateProperty.all(displayMedium),
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            minimumSize: MaterialStateProperty.all(const Size(double.infinity, 56)),
          ),
        ),
      );
}
