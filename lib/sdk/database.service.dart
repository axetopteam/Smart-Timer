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
      timerType: type.name,
      workout: WorkoutParser.encode(type, workout),
      description: description ?? '',
    );
  }

  Future<List<FavoriteWorkout>> fetchFavorites() async {
    final favoritesRawData = await _db.fetchFavorites();

    List<FavoriteWorkout> favorites = [];
    for (var data in favoritesRawData) {
      try {
        final workout = FavoriteWorkout(
          id: data.id,
          name: data.name,
          description: data.description,
          workoutSettings: WorkoutParser.decode(data.workout),
        );
        favorites.add(workout);
      } catch (_) {}
    }
    return favorites;
  }
}
