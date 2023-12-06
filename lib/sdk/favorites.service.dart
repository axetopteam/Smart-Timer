part of 'sdk_service.dart';

extension FavoritesExtension on SdkService {
  Future<void> addToFavorite({
    String? name,
    required WorkoutSettings settings,
    String? description,
  }) async {
    final timerType = TimerType.values.firstWhere((element) => element.name == settings.whichWorkout().name);
    await _db.addWorkoutToFavorite(
      name: name ?? '',
      timerType: timerType.name,
      workout: WorkoutParser.encode(timerType, settings),
      description: description ?? '',
    );
  }

  Stream<List<FavoriteWorkout>> favoritesStream(TimerType? type) {
    return _db.fetchFavorites(type).map(
      (favoritesRawData) {
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
      },
    );
  }

  Future<int> deleteFavorite(int id) {
    return _db.deleteFavorite(id);
  }
}
