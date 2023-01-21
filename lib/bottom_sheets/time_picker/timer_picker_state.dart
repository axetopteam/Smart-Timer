import 'package:mobx/mobx.dart';

part 'timer_picker_state.g.dart';

class TimerPickerState = TimerPickerStateBase with _$TimerPickerState;

abstract class TimerPickerStateBase with Store {
  TimerPickerStateBase({
    required this.minutesList,
    required this.secondsList,
    required Duration initialDuration,
  }) {
    setInitialValues(initialDuration);
  }

  void setInitialValues(Duration initialDuration) {
    final initialMinutes = initialDuration.inMinutes;
    final initialSeconds = initialDuration.inSeconds - initialMinutes * 60;
    minutesIndex = minutesList.indexWhere((element) => element == initialMinutes, 0);
    secondsIndex = secondsList.indexWhere((element) => element == initialSeconds, 0);
  }

  final List<int> minutesList;
  final List<int> secondsList;

  @observable
  int? minutesIndex;

  @observable
  int? secondsIndex;

  @computed
  int? get minutes => minutesIndex != null ? minutesList[minutesIndex!] : null;

  @computed
  int? get seconds => secondsIndex != null ? secondsList[secondsIndex!] : null;

  @observable
  bool noTimeCap = false;
}
