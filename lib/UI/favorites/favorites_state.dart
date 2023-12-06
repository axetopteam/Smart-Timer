import 'package:mobx/mobx.dart';
import 'package:smart_timer/UI/timer/timer_type.dart';

part 'favorites_state.g.dart';

class FavoritesState = _FavoritesState with _$FavoritesState;

abstract class _FavoritesState with Store {
  @observable
  TimerType? selectedType;

  @action
  void selectType(TimerType? newType) {
    selectedType = newType;
  }
}
