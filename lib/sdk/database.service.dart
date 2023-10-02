part of 'sdk_service.dart';

extension DatabaseExtension on SdkService {
  Future<void> addToFavorite({
    String? name,
    required WorkoutSettings workout,
    String? description,
  }) async {
    final timerType = TimerType.values.firstWhere((element) => element.name == workout.whichWorkout().name);
    await _db.addWorkoutToFavorite(
      name: name ?? '',
      timerType: timerType.name,
      workout: WorkoutParser.encode(timerType, workout),
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
            type: TimerType.values.firstWhere((element) => element.name == data.timerType));
        favorites.add(workout);
      } catch (_) {}
    }
    return favorites;
  }
}
