import 'package:smart_timer/models/workout.dart';

abstract class RouterInterface {
  void showMainPage();
  void showTabataSettings();
  void showTimer(Workout workout);
  void showEmomSettings();
  void showAmrapSettings();
}
