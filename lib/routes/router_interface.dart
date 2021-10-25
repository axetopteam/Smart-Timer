import 'package:smart_timer/models/round.dart';

abstract class RouterInterface {
  void showMainPage();
  void showTabata();
  void showTimer(Round workout);
  void showEmom();
  void showAmrap();
  void showAfap();
  void showCustomSettings();
}
