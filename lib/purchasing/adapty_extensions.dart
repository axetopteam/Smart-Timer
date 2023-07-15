import 'package:adapty_flutter/adapty_flutter.dart';

const String premiumAccessLevelKey = 'premium';

extension AdaptyProfileX on AdaptyProfile {
  AdaptyAccessLevel? get premiumAccessLevel => accessLevels[premiumAccessLevelKey];

  bool get hasPremium => premiumAccessLevel?.isActive ?? false;
}

extension AdaptyPaywallProductX on AdaptyPaywallProduct {
  bool get isUnlim => subscriptionPeriod == null;

  String? get readbleSubscriptionPeriod => isUnlim ? 'Lifetime' : localizedSubscriptionPeriod;

  bool get trialIsAvailable =>
      introductoryOfferEligibility == AdaptyEligibility.eligible && introductoryDiscount != null;
}
