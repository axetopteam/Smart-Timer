import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/analytics/analytics_manager.dart';
import 'package:smart_timer/purchasing/adapty_extensions.dart';
import 'package:smart_timer/purchasing/purchase_manager.dart';

export 'package:smart_timer/purchasing/adapty_extensions.dart';

part 'adapty_profile_state.g.dart';

// ignore: library_private_types_in_public_api
class AdaptyProfileState = _AdaptyProfileState with _$AdaptyProfileState;

abstract class _AdaptyProfileState with Store {
  _AdaptyProfileState() {
    checkSubscriptionStatus();
  }
  @observable
  AdaptyProfile? profile;

  @computed
  bool get isPremiumActive => profile?.premiumAccessLevel?.isActive ?? false;

  @action
  void updatePremiumStatus(AdaptyProfile profile) {
    this.profile = profile;
    AnalyticsManager().setUserProperty('subscriber', isPremiumActive);
  }

  Future<void> checkSubscriptionStatus() async {
    final profile = await PurchaseManager().getProfile();
    if (profile == null) return;

    updatePremiumStatus(profile);
  }
}
