import 'package:easy_localization/easy_localization.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';

enum ActivityType {
  countdown,
  work,
  rest;

  String get redableName {
    switch (this) {
      case ActivityType.countdown:
        return '';
      case ActivityType.work:
        return LocaleKeys.work.tr();
      case ActivityType.rest:
        return LocaleKeys.rest.tr();
    }
  }
}
