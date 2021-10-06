import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromRGBO(20, 20, 20, 1);
  static const Color canvas = Color.fromRGBO(46, 46, 46, 1.0);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color black = Color.fromRGBO(0, 0, 0, 1);
  static const Color black60 = Color.fromRGBO(60, 60, 67, 0.6);
  static const Color text = Color.fromRGBO(46, 46, 46, 1);
  static const Color backgroundBlue = Color.fromRGBO(15, 85, 232, 1);
  static const Color pink = Color.fromRGBO(255, 45, 85, 1);
  static const Color lightBlue = Color.fromRGBO(90, 200, 250, 1);
  static const Color accentBlue = Color.fromRGBO(0, 122, 255, 1);
  static const Color green = Color.fromRGBO(52, 199, 89, 1);
  static const Color gray0 = Color.fromRGBO(247, 247, 250, 1);
  static const Color gray5 = Color.fromRGBO(240, 240, 243, 1);
  static const Color gray10 = Color.fromRGBO(230, 228, 234, 1);
  static const Color gray40 = Color.fromRGBO(154, 153, 162, 1);
  static const Color gray50 = Color.fromRGBO(119, 118, 126, 1);
  static const Color gray70 = Color.fromRGBO(35, 35, 38, 1);
  static const Color backgroundColor = gray5;
  static const Color white10 = Color.fromRGBO(255, 255, 255, 0.1);
  static const Color white30 = Color.fromRGBO(255, 255, 255, 0.3);
  static const Color mainBackground = Color.fromRGBO(247, 247, 250, 1);
  static const Color orange = Color.fromRGBO(255, 149, 0, 1);
  static const Color red = Color.fromRGBO(255, 59, 48, 1);

  static const Color transparent = Colors.transparent;
  static const Color accent = Color.fromRGBO(117, 52, 255, 1);
  static const Color iosQuaterniary = Color.fromRGBO(116, 116, 128, 0.08);
  static const Color messageBackground = Color.fromRGBO(244, 244, 245, 1.0);
}

class AppFonts {
  static const TextStyle heading = TextStyle(fontSize: 16, color: AppColors.white, fontWeight: FontWeight.bold);
  static const TextStyle button = TextStyle(fontFamily: '.SF Pro Display', color: AppColors.text, fontWeight: FontWeight.w600, fontSize: 18);
  static const TextStyle loginTitle = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 17, fontWeight: FontWeight.w400, color: Colors.black);
  static const TextStyle loginSubtitle = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.black60);
  static const TextStyle loginCodeField = TextStyle(fontFamily: 'SFMonoCustom', fontSize: 34, fontWeight: FontWeight.w700, color: AppColors.black, letterSpacing: 35.6);
  static const TextStyle loginEmailField = TextStyle(fontFamily: 'SFProDisplayCustom', fontSize: 17, fontWeight: FontWeight.w400, color: AppColors.black);
  static const TextStyle dialogTitle = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black, letterSpacing: -0.41);
  static const TextStyle dialogMessage = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 13, fontWeight: FontWeight.w400, color: Colors.black, letterSpacing: -0.08);
  static const TextStyle exitButton = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.pink);
  static const TextStyle header = TextStyle(fontFamily: 'SFProDisplayCustom', fontSize: 34, fontWeight: FontWeight.w700, color: AppColors.gray70, letterSpacing: 0.4);
  static const TextStyle header2 = TextStyle(fontFamily: 'SFProDisplayCustom', fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.gray70);
  static const TextStyle header3 = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.gray40);
  static const TextStyle subhead = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.black);
  static const TextStyle userName = TextStyle(fontFamily: 'SFProDisplayCustom', fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.black, letterSpacing: 0.35);
  static const TextStyle body = TextStyle(fontFamily: 'SFProDisplay', fontSize: 17, fontWeight: FontWeight.w400, color: AppColors.black, letterSpacing: -0.41);
  static const TextStyle time = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.gray70);
  static const TextStyle profileItem = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 17, fontWeight: FontWeight.w400, color: AppColors.gray70);
  static const TextStyle actionButton = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 17, color: AppColors.accent, letterSpacing: -0.41);
  static const TextStyle segmentController = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 13, color: AppColors.white);
  static const TextStyle notificationText = TextStyle(fontSize: 17, color: AppColors.white);
  static const TextStyle rateText = TextStyle(fontFamily: '.SFProText', fontSize: 17, color: AppColors.black);
  static const TextStyle configText = TextStyle(fontFamily: '.SFProText', fontSize: 17, color: AppColors.black);
  static const TextStyle buttonTitle = TextStyle(fontFamily: '.SFProText', fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: -0.41);
  static const TextStyle userMicMuted = TextStyle(fontFamily: '.SFProText', fontSize: 17, fontWeight: FontWeight.w400, color: AppColors.white);
  static const TextStyle nameField = TextStyle(fontFamily: 'SFProDisplayCustom', fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.black);
  static const TextStyle connectingStateMessage = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 17, fontWeight: FontWeight.w400, color: AppColors.white30);
  static const TextStyle title1 = TextStyle(fontFamily: '.SFProDisplay', fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.black, letterSpacing: 0.36);
  static const TextStyle callRequestTime = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.gray40, letterSpacing: -0.08);
  static const TextStyle callbackButton = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.green, letterSpacing: -0.08);
  static const TextStyle appVersion = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.gray40);
  static const TextStyle productInfoTitle = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 17, fontWeight: FontWeight.w400, color: AppColors.white);
  static const TextStyle workTime = TextStyle(fontFamily: 'SFProDisplayCustom', fontSize: 22, fontWeight: FontWeight.w400, color: AppColors.black);
  static const TextStyle ts13b = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: -0.08);
  static const TextStyle headline = TextStyle(fontFamily: '.SFProText', fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.gray70, letterSpacing: -0.41);
  static const TextStyle unreadCount = TextStyle(fontFamily: '.SFProText', fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.white, letterSpacing: -0.41);
  static const TextStyle navActionTextStyle = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 17, fontWeight: FontWeight.w400, color: AppColors.accent, letterSpacing: -0.41);
  static const TextStyle channelPreviewTitle = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.black, letterSpacing: -0.41);
  static const TextStyle channelPreviewUnreadCount = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.white, letterSpacing: -0.41);
  static const TextStyle smallHelper = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black60, letterSpacing: 0.12);
  static const TextStyle smallHeader = TextStyle(fontFamily: 'SFProTextCustom', fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.black60, letterSpacing: -.08);
  static const TextStyle ownChatMessage = TextStyle(fontFamily: '.Arial', fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.white);
  static const TextStyle otherChatMessage = TextStyle(fontFamily: '.Arial', fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.black);

  static const TextStyle messageAuthor = TextStyle(fontFamily: '.Arial', fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.black60);

  static const cupertinoTextThemeData = CupertinoTextThemeData(
    navLargeTitleTextStyle: TextStyle(fontFamily: 'SFProDisplayCustom', fontSize: 34, fontWeight: FontWeight.w700, color: AppColors.gray70),
    navTitleTextStyle: TextStyle(fontFamily: 'SFProTextCustom', fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.black, letterSpacing: -0.41),
    navActionTextStyle: navActionTextStyle,
    tabLabelTextStyle: TextStyle(fontFamily: 'SFProTextCustom', fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.accent, letterSpacing: -0.24),
  );

  /*static const streamOtherMessageTheme = MessageTheme(
    messageBackgroundColor: AppColors.message_background,
    messageText: AppFonts.otherChatMessage,
    messageAuthor: AppFonts.messageAuthor,
  );

  static const streamOwnMessageTheme = MessageTheme(
    messageBackgroundColor: AppColors.accent,
    messageText: AppFonts.ownChatMessage,
    messageAuthor: AppFonts.messageAuthor,
    // createdAt: TextStyle(color: AppColors.accent),
  );*/
}

class AppDecorations {
  static InputDecoration formInputDecoration({String? hintText, String? labelText}) {
    return InputDecoration(
      hintStyle: AppFonts.body,
      labelStyle: AppFonts.body,
      filled: true,
      hintText: hintText,
      labelText: labelText,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.white),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.white),
      ),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.white),
      ),
    );
  }
}
