part of 'theme.dart';

class AppFonts {
  static const chip = TextStyle(
    fontFamily: 'Inter',
    height: 1,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static const alternativeBodyLarge = TextStyle(
    fontFamily: 'Inter',
    height: 18 / 16,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const bodyLarge = TextStyle(
    fontFamily: 'Inter',
    height: 20 / 18,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static const bodyMedium = TextStyle(
    fontFamily: 'Inter',
    height: 20 / 14,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const displayLarge = TextStyle(
    height: 47 / 60,
    fontSize: 60,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w900,
  );

  static const displayMedium = TextStyle(
    height: 22 / 18,
    fontSize: 18,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w900,
  );

  static const displaySmall = TextStyle(
    fontFamily: 'Montserrat',
    height: 29 / 24,
    fontSize: 24,
    fontWeight: FontWeight.w900,
  );

  static const headlineMedium = TextStyle(
    fontFamily: 'Inter',
    height: 28 / 20,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static const headlineSmall = TextStyle(
    fontFamily: 'Inter',
    height: 90 / 70,
    fontSize: 70,
    fontWeight: FontWeight.w900,
  );

  static const titleLarge = TextStyle(
    fontFamily: 'Montserrat',
    height: 24 / 20,
    fontSize: 20,
    fontWeight: FontWeight.w900,
  );

  static const titleMedium = TextStyle(
    fontFamily: 'Inter',
    height: 20 / 16,
    fontSize: 16,
    fontWeight: FontWeight.w900,
  );

  static const titleSmall = TextStyle(
    fontFamily: 'Inter',
    height: 29 / 24,
    fontSize: 24,
    fontWeight: FontWeight.w900,
  );
}

abstract class AppColors {
  static const white = Colors.white;
  static const black = Color(0xFF0E0E0E);
  static const black20 = Color(0x330E0E0E);
  static const black50 = Color(0x800E0E0E);
  static const black70 = Color(0xB20E0E0E);
  static const red = Color(0xFFFF5151);
  static const greyBlue = Color(0xFF252527);
  static const dullGrey = Color(0xFF666666);
  static const grey = Color(0xFF7C7C7C);
  static const activeGreen = CupertinoColors.activeGreen;
  static const systemRed = CupertinoColors.systemRed;
  static const activeBlue = CupertinoColors.activeBlue;

  static const denimBlue = Color(0xFF254CB0);
  static const darkGreen = Color(0xFF387722);
  static const brightPurple = Color(0xFF8F3A90);
  static const ochre = Color(0xFFC9791C);
  static const greenishBlue = Color(0xFF239C9C);
  static const paleRed = Color(0xFFCC4040);
}
