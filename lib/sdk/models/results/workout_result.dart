import 'interval_result.dart';
import 'result_interface.dart';

class WorkoutResult implements WorkoutResultInterface {
  WorkoutResult({required this.sets});
  final List<WorkoutResultInterface> sets;

  @override
  Duration get totalDuration {
    var res = const Duration();
    for (var element in sets) {
      res += element.totalDuration;
    }
    return res;
  }

  @override
  Map<String, dynamic> toJson() {
    List? dataList;

    dataList = sets.map((element) => (element).toJson()).toList();

    return {
      'type': WorkoutResultType.set.name,
      'data': dataList,
    };
  }

  static WorkoutResultInterface workoutResultParser(Map<String, dynamic> json) {
    final type = WorkoutResultType.values.firstWhere((element) => element.name == json['type']);
    final data = json['data'];
    switch (type) {
      case WorkoutResultType.interval:
        return IntervalResult.fromJson(data);
      case WorkoutResultType.set:
        return WorkoutResult(sets: ((data as List).map((e) => workoutResultParser(e))).toList());
    }
  }
}
