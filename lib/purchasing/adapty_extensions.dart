import 'package:adapty_flutter/adapty_flutter.dart';

const String premiumAccessLevelKey = 'standard';

extension AdaptyProfileX on AdaptyProfile {
  AdaptyAccessLevel? get premiumAccessLevel => accessLevels[premiumAccessLevelKey];
}
