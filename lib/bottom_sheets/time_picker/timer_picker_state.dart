import 'package:mobx/mobx.dart';

part 'timer_picker_state.g.dart';

class TimerPickerState = TimerPickerStateBase with _$TimerPickerState;

abstract class TimerPickerStateBase with Store {
  @observable
  int? minutes;

  @observable
  int? seconds;
}
