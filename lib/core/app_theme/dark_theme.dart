part of 'theme.dart';

ThemeData createDarkTheme() {
  return ThemeData(
    primaryColor: AppColors.activeBlue,
    brightness: Brightness.dark,
    fontFamily: 'Montserrat',
    textTheme: createTextTheme().apply(displayColor: AppColors.white),
    scaffoldBackgroundColor: AppColors.black,
    dividerColor: AppColors.greyBlue,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      titleTextStyle: AppFonts.headlineMedium,
      centerTitle: false,
      elevation: 0,
      toolbarHeight: 70,
      titleSpacing: 20,
      backgroundColor: AppColors.black,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.black,
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.dullGrey,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.white,
      extendedPadding: EdgeInsets.all(40),
      extendedSizeConstraints: BoxConstraints(maxHeight: 56),
    ),
    canvasColor: AppColors.black,
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
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        textStyle: MaterialStateProperty.all(AppFonts.bodyMedium),
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
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStatePropertyAll(Colors.transparent),
        minimumSize: MaterialStatePropertyAll(Size.zero),
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.white),
    cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
      primaryColor: AppColors.activeBlue,
      textTheme: CupertinoTextThemeData(),
      scaffoldBackgroundColor: AppColors.black,
      barBackgroundColor: AppColors.black70,
    ),
    extensions: <ThemeExtension<dynamic>>[
      ThemeColors.dark,
      ThemeButtonStyles.dark,
      ThemeTextStyles.dark,
    ],
  );
}
