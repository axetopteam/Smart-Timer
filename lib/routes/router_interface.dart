import 'package:smart_timer/models/workout.dart';

abstract class RouterInterface {
  void showMainPage();
  void showTabata();
  void showTimer(Workout workout);
  void showEmom();
  void showAmrap();
  void showAfap();
  void showCustomSettings();
}
