import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/services/app_properties.dart';

class ApplicationSupport {
  static Future<void> showSupportDialog(BuildContext context) async {
    final mailOptions = MailOptions(
      body: await _composeInfoBodyString(context),
      subject: 'Support case',
      recipients: ['support@axetop.dev'],
      isHTML: false,
    );
    try {
      await FlutterMailer.send(mailOptions);
      // ignore: empty_catches
    } catch (e) {}
  }

  static Future<String> _composeInfoBodyString(BuildContext context) async {
    final packageInfo = await PackageInfo.fromPlatform();

    final version = packageInfo.version;
    final buildNumber = packageInfo.buildNumber;

    final osVersion = Platform.operatingSystem;
    final userId = AppProperties().userId;
    return '''




-----
${LocaleKeys.settings_support_email_signature.tr()} 

UserId: $userId
System: $osVersion
Version: $version ($buildNumber)
    ''';
  }
}
