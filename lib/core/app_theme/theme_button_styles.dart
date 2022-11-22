part of 'theme.dart';

class ThemeButtonStyles extends ThemeExtension<ThemeButtonStyles> {
  final ElevatedButtonThemeData startButtonTheme;
  final TextButtonThemeData deleteButtonTheme;

  const ThemeButtonStyles({
    required this.startButtonTheme,
    required this.deleteButtonTheme,
  });

  @override
  ThemeExtension<ThemeButtonStyles> copyWith({
    ElevatedButtonThemeData? startButtonTheme,
    TextButtonThemeData? deleteButtonTheme,
  }) {
    return ThemeButtonStyles(
      startButtonTheme: startButtonTheme ?? this.startButtonTheme,
      deleteButtonTheme: deleteButtonTheme ?? this.deleteButtonTheme,
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
    );
  }

  static get dark => ThemeButtonStyles(
        startButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(AppColors.white),
            textStyle: MaterialStateProperty.all(headline2),
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
              textStyle: MaterialStateProperty.all(bodyText2),
              minimumSize: MaterialStateProperty.all(const Size(0, 24)),
              overlayColor: MaterialStateProperty.all(Colors.transparent)),
        ),
      );
}
