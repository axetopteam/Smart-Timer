import 'package:mobx/mobx.dart';
import 'package:smart_timer/UI/timer/timer_type.dart';

part 'favorites_state.g.dart';

// ignore: library_private_types_in_public_api
class FavoritesState = _FavoritesState with _$FavoritesState;

abstract class _FavoritesState with Store {
  @observable
  TimerType? selectedType;

  @action
  void selectType(TimerType? newType) {
    selectedType = newType;
  }
}
