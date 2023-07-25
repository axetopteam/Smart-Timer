import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/widgets/adaptive_alert.dart';

class PurchaseErrorAlert {
  static Future<void> showPurchaseError(BuildContext context, {int? errorCode, String? message}) async {
    return AdaptiveDialog.show(
      context,
      title: LocaleKeys.paywall_purchase_error_title.tr(),
      content: LocaleKeys.paywall_purchase_error_content.tr(
        namedArgs: {
          'errorCode': '${errorCode ?? 'Unknonwn'}',
          'message': message ?? '',
        },
      ),
    );
  }
}
