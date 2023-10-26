import 'package:smart_timer/services/audio_service.dart';

import '../results/result_interface.dart';

abstract class IntervalInterface {
  IntervalInterface();
  Duration? get currentTime;
  DateTime? get finishTimeUtc;
  DateTime? finishTimeFor({required DateTime startTime});
  IntervalInterface get currentInterval;
  IntervalInterface? get nextInterval;
  Map<DateTime, SoundType> get reminders;
  void setDuration({Duration? newDuration});
  bool get isEnded;
  void start(DateTime nowUtc);
  void pause();
  void tick(DateTime nowUtc);
  IntervalInterface copy();
  WorkoutResultInterface toResult();
}
