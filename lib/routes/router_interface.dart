import 'package:smart_timer/models/interval.dart';

abstract class RouterInterface {
  void showMainPage();
  void showTabataSettings();
  void showTabataTimer(List<Interval> schedule);
}
