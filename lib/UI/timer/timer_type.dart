import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';

enum TimerType {
  amrap('00'),
  afap('01'),
  emom('02'),
  tabata('03'),
  workRest('04');
  // custom('05');

  final String hexCode;
  const TimerType(this.hexCode);

  String get readbleName {
    switch (this) {
      case TimerType.amrap:
        return LocaleKeys.amrap_title.tr();
      case TimerType.afap:
        return LocaleKeys.afap_title.tr();
      case TimerType.emom:
        return LocaleKeys.emom_title.tr();
      case TimerType.tabata:
        return LocaleKeys.tabata_title.tr();
      case TimerType.workRest:
        return LocaleKeys.work_rest_title.tr();
      // case TimerType.custom:
      //   return 'Custom';
    }
  }

  Color workoutColor(BuildContext context) {
    switch (this) {
      case TimerType.amrap:
        return context.color.amrapColor;
      case TimerType.afap:
        return context.color.afapColor;
      case TimerType.emom:
        return context.color.emomColor;
      case TimerType.tabata:
        return context.color.tabataColor;
      case TimerType.workRest:
        return context.color.workRestColor;
      // case TimerType.custom:
      //   return context.color.customColor;
    }
  }

  bool get showTotalTime {
    switch (this) {
      case TimerType.amrap:
      case TimerType.emom:
      case TimerType.tabata:
        return true;

      case TimerType.afap:
      case TimerType.workRest:
        // case TimerType.custom:
        return false;
    }
  }

  factory TimerType.fromHexCode(String code) {
    return TimerType.values.firstWhere((element) => element.hexCode == code);
  }
}
