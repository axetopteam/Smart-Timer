abstract class IntervalInterface {
  Duration get currentTime;
  DateTime? get finishTimeUtc;
  bool get isEnded;
  void start(DateTime nowUtc);
  void pause();
  void tick(DateTime nowUtc);
  Map<int, List<int>> get indexes;
  IntervalInterface copy();
  String description();
}
