import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_timer/UI/timer/timer_type.dart';

import 'models/protos/workout_settings/workout_settings.pb.dart';

class WorkoutParser {
  static WorkoutSettings decode(String rawData) {
    // ignore: unused_local_variable
    final parserVersionCode = rawData.substring(0, 2); //is not used yet
    final workoutHex = rawData.substring(2);
    final workoutData = HexUtils.decode(workoutHex);

    return WorkoutSettings.fromBuffer(workoutData);
  }

  static String encode(TimerType type, WorkoutSettings workoutSettings) {
    // ignore: unused_local_variable
    const versionCode = '01'; //is not used yet
    final Uint8List workoutData = workoutSettings.writeToBuffer();

    final workoutHex = HexUtils.encode(workoutData);

    return '$versionCode$workoutHex';
  }
}
