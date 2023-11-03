import 'package:easy_localization/easy_localization.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';

enum IntervalType {
  countdown,
  work,
  rest;

  String get redableName {
    switch (this) {
      case IntervalType.countdown:
        return '';
      case IntervalType.work:
        return LocaleKeys.work.tr();
      case IntervalType.rest:
        return LocaleKeys.rest.tr();
    }
  }
}
