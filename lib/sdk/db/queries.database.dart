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

  Future<List<FavoriteWorkoutRawData>> fetchFavorites() {
    return select(favoriteWorkouts).get();
  }
}
