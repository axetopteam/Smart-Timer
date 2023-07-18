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

extension AdaptySubscriptionPeriodX on AdaptySubscriptionPeriod {
  int? get inDays {
    switch (unit) {
      case AdaptyPeriodUnit.day:
        return numberOfUnits;
      case AdaptyPeriodUnit.week:
        return 7 * numberOfUnits;
      case AdaptyPeriodUnit.month:
        return 30 * numberOfUnits;
      case AdaptyPeriodUnit.year:
        return 365 * numberOfUnits;
      case AdaptyPeriodUnit.unknown:
        return null;
    }
  }
}
