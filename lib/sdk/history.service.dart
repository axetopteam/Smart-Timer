part of 'sdk_service.dart';

extension HistoryExtension on SdkService {
  Future<void> saveTrainingToHistory({
    required DateTime finishAt,
    required String name,
    required String description,
    int? wellBeing,
    required WorkoutSettings workoutSettings,
    required TimerType timerType,
    required WorkoutSet training,
    required bool isFinished,
  }) async {
    await _db.saveTrainingToHistory(
      finishAt: finishAt.millisecondsSinceEpoch,
      name: name,
      description: description,
      wellBeing: wellBeing,
      timerType: timerType.name,
      workout: WorkoutParser.encode(timerType, workoutSettings),
      training: jsonEncode(training.toJson()),
      isFinished: isFinished,
    );
  }
}
