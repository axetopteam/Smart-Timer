part of 'sdk_service.dart';

extension HistoryExtension on SdkService {
  Future<void> saveTrainingToHistory({
    required DateTime finishAt,
    required String name,
    required String description,
    int? wellBeing,
    required WorkoutSettings workoutSettings,
    required TimerType timerType,
    required WorkoutResult result,
    required bool isFinished,
  }) async {
    await _db.saveTrainingToHistory(
      finishAt: finishAt.millisecondsSinceEpoch,
      name: name,
      description: description,
      wellBeing: wellBeing,
      timerType: timerType.name,
      workout: WorkoutParser.encode(timerType, workoutSettings),
      result: jsonEncode(result.toJson()),
      isFinished: isFinished,
    );
  }

  Future<List<TrainingHistoryRecord>> fetchHistory({int offset = 0, int limit = 10}) async {
    final res = await _db.fetchHistory(limit: limit, offset: offset);
    return res.map((e) {
      final timerType = TimerType.values.firstWhere((element) => element.name == e.timerType);
      return TrainingHistoryRecord(
        id: e.id,
        dateTime: DateTime.fromMillisecondsSinceEpoch(e.finishAt),
        name: e.name,
        description: e.description,
        workout: WorkoutParser.decode(e.workout),
        timerType: timerType,
        result: WorkoutResult.workoutResultParser(jsonDecode(e.result)),
      );
    }).toList();
  }
}
