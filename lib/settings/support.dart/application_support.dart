import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
    final userId = GetIt.I<AppProperties>().userId;
    //TODO: localization
    return '''




-----
"Type your feedback or describe your problem above this line.\n\nPlease don't delete or edit the information below." 

UserId: $userId
System: $osVersion
Version: $version ($buildNumber)
    ''';
  }
}
