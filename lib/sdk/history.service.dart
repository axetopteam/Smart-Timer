part of 'sdk_service.dart';

extension HistoryExtension on SdkService {
  Future<TrainingHistoryRecord> saveTrainingToHistory({
    required DateTime finishAt,
    required String name,
    required String description,
    int? wellBeing,
    required WorkoutSettings workoutSettings,
    required TimerType timerType,
    required WorkoutResult result,
    required bool isFinished,
  }) async {
    final res = await _db.saveTrainingToHistory(
      finishAt: finishAt.millisecondsSinceEpoch,
      name: name,
      description: description,
      wellBeing: wellBeing,
      timerType: timerType.name,
      workout: WorkoutParser.encode(timerType, workoutSettings),
      result: jsonEncode(result.toJson()),
      isFinished: isFinished,
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
      finishAt: DateTime.fromMillisecondsSinceEpoch(finishAt),
      name: name,
      description: description,
      workout: WorkoutParser.decode(workout),
      timerType: timerType,
      result: WorkoutResult.workoutResultParser(jsonDecode(result)),
      isCompleted: isFinished,
    );
  }
}
