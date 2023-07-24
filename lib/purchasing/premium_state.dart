import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/analytics/analytics_manager.dart';
import 'package:smart_timer/purchasing/adapty_extensions.dart';
import 'package:smart_timer/purchasing/purchase_manager.dart';

part 'premium_state.g.dart';

// ignore: library_private_types_in_public_api
class PremiumState = _PremiumState with _$PremiumState;

abstract class _PremiumState with Store {
  @observable
  bool _isPremiumActive = false;

  @computed
  bool get isPremiumActive => _isPremiumActive;

  @action
  void updatePremiumStatus(AdaptyProfile profile) {
    _isPremiumActive = profile.premiumAccessLevel?.isActive ?? false;
    AnalyticsManager().setUserProperty('subscriber', _isPremiumActive);
  }

  Future<void> checkSubscriptionStatus() async {
    final profile = await PurchaseManager().getProfile();
    if (profile == null) return;

    updatePremiumStatus(profile);

    // final vendorProductId = profile.premiumAccessLevel?.vendorProductId;

    // if (premium && vendorProductId != null) {
    //   final product = getProductById(vendorProductId);
    //   final productInfo = product != null ? ProductInfo(product) : null;
    //   if (productInfo != null) {
    //     AnalyticsManager.instance.setUserProperty('product_id', productInfo.productId);
    //     AnalyticsManager.instance.setUserProperty('free_trial_type', '${productInfo.trialPeriodDurationInDays}_days');
    //   } else {
    //     AnalyticsManager.instance.setUserProperty('product_id', vendorProductId);
    //   }
    // }
  }
}
