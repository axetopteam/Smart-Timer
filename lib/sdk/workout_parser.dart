import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_timer/timer/timer_type.dart';

import 'models/protos/afap_settings/afap_settings.pb.dart';
import 'models/protos/amrap_settings/amrap_settings.pb.dart';
import 'models/protos/emom_settings/emom_settings.pb.dart';
import 'models/protos/tabata_settings/tabata_settings.pb.dart';
import 'models/protos/work_rest_settings/work_rest_settings.pb.dart';

class WorkoutParser {
  Object decode(String rawData) {
    final typeCode = rawData.substring(0, 2);
    // ignore: unused_local_variable
    final parserVersionCode = rawData.substring(2, 4); //is not used yet
    final workoutHex = rawData.substring(4);
    final workoutData = HexUtils.decode(workoutHex);

    final type = TimerType.values.firstWhere((element) => element.hexCode == typeCode);

    switch (type) {
      case TimerType.amrap:
        return AmrapSettings.fromBuffer(workoutData);
      case TimerType.afap:
        return AfapSettings.fromBuffer(workoutData);
      case TimerType.emom:
        return EmomSettings.fromBuffer(workoutData);
      case TimerType.tabata:
        return TabataSettings.fromBuffer(workoutData);
      case TimerType.workRest:
        return WorkRestSettings.fromBuffer(workoutData);
      // case TimerType.custom:
    }
  }

  String encode(TimerType type, Object workoutSettings) {
    final typeCode = type.hexCode;
    // ignore: unused_local_variable
    const versionCode = '01'; //is not used yet
    late final Uint8List workoutData;

    switch (workoutSettings.runtimeType) {
      case AmrapSettings:
        workoutData = (workoutSettings as AmrapSettings).writeToBuffer();
      case AfapSettings:
        workoutData = (workoutSettings as AfapSettings).writeToBuffer();
      case EmomSettings:
        workoutData = (workoutSettings as EmomSettings).writeToBuffer();
      case TabataSettings:
        workoutData = (workoutSettings as TabataSettings).writeToBuffer();
      case WorkRestSettings:
        workoutData = (workoutSettings as WorkRestSettings).writeToBuffer();
      // case TimerType.custom:
    }

    final workoutHex = HexUtils.encode(workoutData);

    return '$typeCode$versionCode$workoutHex';
  }
}
