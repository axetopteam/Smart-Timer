import 'package:drift/drift.dart';
import 'package:smart_timer/UI/timer/timer_type.dart';

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

  Stream<List<FavoriteWorkoutRawData>> fetchFavorites(TimerType? type) {
    if (type != null) {
      return (select(favoriteWorkouts)
            ..where((tbl) => tbl.timerType.equals(type.name))
            ..orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)]))
          .watch();
    } else {
      return (select(favoriteWorkouts)..orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)]))
          .watch();
    }
  }

  Future<int> deleteFavorite(int id) {
    return (delete(favoriteWorkouts)..where((t) => t.id.equals(id))).go();
  }

  Future<TrainingHistoryRawData> saveTrainingToHistory({
    required int startAt,
    required int endAt,
    required String name,
    required String description,
    int? wellBeing,
    required String workout,
    required String timerType,
    required String intervals,
    required String pauses,
  }) {
    final entry = TrainingHistoryCompanion.insert(
      startAt: startAt,
      endAt: endAt,
      name: Value(name),
      description: Value(description),
      wellBeing: Value(wellBeing),
      workout: workout,
      timerType: timerType,
      intervals: intervals,
      pauses: Value(pauses),
    );
    return into(trainingHistory).insertReturning(entry);
  }

  Future<List<TrainingHistoryRawData>> fetchHistory({int offset = 0, int limit = 10}) {
    return (select(trainingHistory)
          ..orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)])
          ..limit(limit, offset: offset))
        .get();
  }

  Future<List<TrainingHistoryRawData>> updateTainingHistoryRecord(
      {required int id, String? name, String? description}) async {
    return await (update(trainingHistory)..where((t) => t.id.equals(id))).writeReturning(
      TrainingHistoryCompanion(
        name: name != null ? Value(name) : const Value.absent(),
        description: description != null ? Value(description) : const Value.absent(),
      ),
    );
  }

  Future<int> deleteTrainingHistoryRecord(int id) {
    return (delete(trainingHistory)..where((t) => t.id.equals(id))).go();
  }
}
