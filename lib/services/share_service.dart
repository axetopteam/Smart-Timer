import 'package:share_plus/share_plus.dart';
import 'package:smart_timer/UI/timer/timer_type.dart';
import 'package:smart_timer/sdk/models/protos/workout_settings/workout_settings.pb.dart';
import 'package:smart_timer/sdk/workout_parser.dart';

/// ShareService singleton class
class ShareService {
  static final ShareService _internalSingleton = ShareService._internal();
  factory ShareService() => _internalSingleton;
  ShareService._internal();

  Future<bool> shareWorkout(TimerType type, WorkoutSettings workoutSettings) async {
    final content = WorkoutParser.encode(type, workoutSettings);
    final res = await Share.shareWithResult(content);

    return res.status == ShareResultStatus.success;
  }
}
