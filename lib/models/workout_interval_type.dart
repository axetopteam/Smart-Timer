import 'package:easy_localization/easy_localization.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';

enum WorkoutIntervalType {
  countdown,
  work,
  rest;

  String get redableName {
    switch (this) {
      case WorkoutIntervalType.countdown:
        return '';
      case WorkoutIntervalType.work:
        return LocaleKeys.work.tr();
      case WorkoutIntervalType.rest:
        return LocaleKeys.rest.tr();
    }
  }
}
