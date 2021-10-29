import 'package:smart_timer/models/workout_set.dart';

abstract class RouterInterface {
  void showMainPage();
  void showTabata();
  void showTimer(WorkoutSet workout);
  void showEmom();
  void showAmrap();
  void showAfap();
  void showWorkRest();
  void showCustomSettings();
}
