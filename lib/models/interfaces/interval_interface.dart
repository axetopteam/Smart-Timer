import 'package:smart_timer/services/audio_service.dart';

abstract class IntervalInterface {
  Duration? get currentTime;
  DateTime? get finishTimeUtc;
  Map<int, List<int>> get indexes;
  IntervalInterface get currentInterval;
  IntervalInterface? get nextInterval;
  Map<DateTime, SoundType> get reminders;
  void setDuration({Duration? newDuration});
  bool get isEnded;
  void start(DateTime nowUtc);
  void pause();
  void tick(DateTime nowUtc);
  IntervalInterface copy();
  String description();
}
