import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:protobuf/protobuf.dart';
import 'package:smart_timer/timer/timer_type.dart';

import 'models/protos/afap_settings/afap_settings.pb.dart';
import 'models/protos/amrap_settings/amrap_settings.pb.dart';
import 'models/protos/emom_settings/emom_settings.pb.dart';
import 'models/protos/tabata_settings/tabata_settings.pb.dart';
import 'models/protos/work_rest_settings/work_rest_settings.pb.dart';

class WorkoutParser {
  static (TimerType, GeneratedMessage) decode(String rawData) {
    final typeCode = rawData.substring(0, 2);
    // ignore: unused_local_variable
    final parserVersionCode = rawData.substring(2, 4); //is not used yet
    final workoutHex = rawData.substring(4);
    final workoutData = HexUtils.decode(workoutHex);

    final type = TimerType.values.firstWhere((element) => element.hexCode == typeCode);

    switch (type) {
      case TimerType.amrap:
        return (TimerType.amrap, AmrapSettings.fromBuffer(workoutData));
      case TimerType.afap:
        return (TimerType.afap, AfapSettings.fromBuffer(workoutData));
      case TimerType.emom:
        return (TimerType.emom, EmomSettings.fromBuffer(workoutData));
      case TimerType.tabata:
        return (TimerType.tabata, TabataSettings.fromBuffer(workoutData));
      case TimerType.workRest:
        return (TimerType.workRest, WorkRestSettings.fromBuffer(workoutData));
      // case TimerType.custom:
    }
  }

  static String encode(TimerType type, GeneratedMessage workoutSettings) {
    final typeCode = type.hexCode;
    // ignore: unused_local_variable
    const versionCode = '01'; //is not used yet
    final Uint8List workoutData = workoutSettings.writeToBuffer();

    final workoutHex = HexUtils.encode(workoutData);

    return '$typeCode$versionCode$workoutHex';
  }
}
