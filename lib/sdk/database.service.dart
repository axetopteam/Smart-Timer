part of 'sdk_service.dart';

extension DatabaseExtension on SdkService {
  Future<void> addToFavorite({
    required TimerType type,
    String? name,
    required WorkoutSettings workout,
    String? description,
  }) async {
    await _db.addWorkoutToFavorite(
      name: name ?? '',
      workout: WorkoutParser.encode(type, workout),
      description: description ?? '',
    );
  }

  fetchFavorites() async {
    final favoritesRawData = await _db.fetchFavorites();
    return favoritesRawData.map((e) {
      final workoutSettings = WorkoutParser.decode(e.workout);

      return FavoriteWorkout(
        id: e.id,
        name: e.name,
        description: e.description,
        workoutSettings: workoutSettings,
      );
    }).toList();
  }
}
