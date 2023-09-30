import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/sdk/sdk_service.dart';

export 'package:smart_timer/sdk/sdk_service.dart' show FavoriteWorkout, TimerType;

part 'favorites_state.g.dart';

class FavoritesState = FavoritesStateBase with _$FavoritesState;

abstract class FavoritesStateBase with Store {
  FavoritesStateBase() {
    fetchFavorites();
  }

  SdkService get _sdk => GetIt.I();

  @observable
  List<FavoriteWorkout>? favorites;

  @observable
  Object? error;

  @action
  Future<void> fetchFavorites() async {
    try {
      favorites = await _sdk.fetchFavorites();
    } catch (e) {
      error = e;
    }
  }
}
