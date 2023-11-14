part of 'sdk_service.dart';

extension HistoryExtension on SdkService {
  Future<TrainingHistoryRecord> saveTrainingToHistory({
    required DateTime startAt,
    required DateTime endAt,
    required String name,
    required String description,
    int? wellBeing,
    required WorkoutSettings workoutSettings,
    required TimerType timerType,
    required List<Interval> intervals,
  }) async {
    final res = await _db.saveTrainingToHistory(
      startAt: startAt.millisecondsSinceEpoch,
      endAt: endAt.millisecondsSinceEpoch,
      name: name,
      description: description,
      wellBeing: wellBeing,
      timerType: timerType.name,
      workout: WorkoutParser.encode(timerType, workoutSettings),
      intervals: jsonEncode(intervals.map((e) => e.toJson())),
    );
    return res.toHistoryRecord();
  }

  Future<List<TrainingHistoryRecord>> fetchHistory({int offset = 0, int limit = 10}) async {
    final res = await _db.fetchHistory(limit: limit, offset: offset);
    return res.map((e) => e.toHistoryRecord()).toList();
  }
}

extension on TrainingHistoryRawData {
  TrainingHistoryRecord toHistoryRecord() {
    final timerType = TimerType.values.firstWhere((element) => element.name == this.timerType);

    return TrainingHistoryRecord(
      id: id,
      startAt: DateTime.fromMillisecondsSinceEpoch(startAt),
      endAt: DateTime.fromMillisecondsSinceEpoch(endAt),
      name: name,
      description: description,
      workout: WorkoutParser.decode(workout),
      timerType: timerType,
      intervals: (jsonDecode(intervals) as List).map((json) => Interval.fromJson(json)).toList(),
    );
  }
}
