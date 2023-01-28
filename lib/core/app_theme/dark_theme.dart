part of 'theme.dart';

ThemeData createDarkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Montserrat',
    textTheme: createTextTheme().apply(displayColor: AppColors.white),
    scaffoldBackgroundColor: AppColors.black,
    backgroundColor: AppColors.black,
    dividerColor: AppColors.greyBlue,
    appBarTheme: const AppBarTheme(
      titleTextStyle: headline3,
      centerTitle: false,
      elevation: 0,
      toolbarHeight: 70,
      titleSpacing: 36,
      backgroundColor: AppColors.black,
    ),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColors.dullGrey;
            }
            return AppColors.greyBlue;
          },
        ),
        foregroundColor: MaterialStateProperty.all(AppColors.white),
        textStyle: MaterialStateProperty.all(bodyText2),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        minimumSize: MaterialStateProperty.all(
          const Size(double.infinity, 56),
        ),
      ),
    ),
    extensions: <ThemeExtension<dynamic>>[
      ThemeColors.dark,
      ThemeButtonStyles.dark,

      // ThemeTextStyles.light,
    ],
  );
}
