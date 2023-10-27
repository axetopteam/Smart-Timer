abstract class WorkoutResultInterface {
  Map<String, dynamic> toJson();
  Duration get totalDuration;
}

enum WorkoutResultType { set, interval }
