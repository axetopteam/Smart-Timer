import 'package:drift/drift.dart';

import 'database.dart';

extension DatabaseQueries on AppDatabase {
  Future<int> addWorkoutToFavorite({
    required String name,
    required String workout,
    required String timerType,
    required String description,
  }) {
    final entry = FavoriteWorkoutsCompanion.insert(
      name: Value(name),
      workout: workout,
      timerType: timerType,
      description: Value(description),
    );
    return into(favoriteWorkouts).insert(entry);
  }

  Stream<List<FavoriteWorkoutRawData>> fetchFavorites() {
    return select(favoriteWorkouts).watch();
  }

  Future<int> deleteFavorite(int id) {
    return (delete(favoriteWorkouts)..where((t) => t.id.equals(id))).go();
  }

  Future<int> saveTrainingToHistory({
    required int finishAt,
    required String name,
    required String description,
    int? wellBeing,
    required String workout,
    required String timerType,
    required String training,
    required bool isFinished,
  }) {
    final entry = TrainingHistoryCompanion.insert(
        finishAt: finishAt,
        name: Value(name),
        description: Value(description),
        wellBeing: Value(wellBeing),
        workout: workout,
        timerType: timerType,
        training: training,
        isFinished: isFinished);
    return into(trainingHistory).insert(entry);
  }
}
