import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  static Future<bool> tryLaunchUrl(String urlString, {LaunchMode? mode}) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: mode ?? (Platform.isAndroid ? LaunchMode.externalApplication : LaunchMode.platformDefault),
      );
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> openPrivacyPolicy() {
    return tryLaunchUrl('https://axetop.dev/easytimer/privacy');
  }

  static Future<bool> openTermsOfUse() {
    return tryLaunchUrl('https://axetop.dev/easytimer/terms');
  }
}
