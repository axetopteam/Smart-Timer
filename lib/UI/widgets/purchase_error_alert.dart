import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';

import 'adaptive_alert.dart';

class PurchaseErrorAlert {
  static Future<void> showPurchaseError(BuildContext context, {int? errorCode, String? message}) async {
    return AdaptiveDialog.show(
      context,
      title: LocaleKeys.paywall_purchase_error_title.tr(),
      content: '${errorCode != null ? 'errorCode: $errorCode\n' : ''}${message ?? ''}',
    );
  }

  static Future<void> showRestoreError(BuildContext context, {int? errorCode, String? message}) async {
    return AdaptiveDialog.show(
      context,
      title: LocaleKeys.paywall_restore_error_title.tr(),
      content: '${errorCode != null ? 'errorCode: $errorCode\n' : ''}${message ?? ''}',
    );
  }
}
