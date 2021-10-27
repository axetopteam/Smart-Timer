abstract class IntervalInterface {
  void start(DateTime nowUtc);
  void pause();
  void tick(DateTime nowUtc);
  Duration? get currentTime;
  DateTime? get finishTimeUtc;
  bool get isEnded;
  Map<int, List<int>> get indexes;
  IntervalInterface copy();
  String description();
  IntervalInterface get currentInterval;
  IntervalInterface? get nextInterval;
}
