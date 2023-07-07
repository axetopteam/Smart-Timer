import 'package:mobx/mobx.dart';

part 'timer_picker_state.g.dart';

class TimerPickerState = TimerPickerStateBase with _$TimerPickerState;

abstract class TimerPickerStateBase with Store {
  TimerPickerStateBase({
    required this.minutesList,
    required this.secondsList,
    required Duration initialDuration,
  })  : minutesIndex = minutesList.indexWhere((element) => element == initialDuration.inMinutes, 0),
        secondsIndex = secondsList.indexWhere(
            (element) => element == (initialDuration.inSeconds - initialDuration.inMinutes * 60), 0);

  final List<int> minutesList;
  final List<int> secondsList;

  @observable
  late int minutesIndex;

  @observable
  late int secondsIndex;

  @computed
  int get minutes => minutesList[minutesIndex];

  @computed
  int get seconds => secondsList[secondsIndex];

  void setDuration(Duration duration) {
    minutesIndex = minutesList.indexWhere((element) => element == duration.inMinutes, 0);
    secondsIndex = secondsList.indexWhere((element) => element == (duration.inSeconds - duration.inMinutes * 60), 0);
  }
}
