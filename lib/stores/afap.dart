import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';

part 'afap.g.dart';

class Afap = AfapBase with _$Afap;

abstract class AfapBase with Store {
  @observable
  Interval workTime = Interval(
    duration: null,
    type: IntervalType.work,
    isCountdown: false,
  );

  @computed
  WorkoutSet get workout {
    final round = WorkoutSet([workTime]);
    return round.copy();
  }

  @action
  void setTimeCap(Duration? duration) {
    workTime = Interval(
      duration: duration ?? const Duration(days: 14),
      type: IntervalType.work,
      isCountdown: false,
    );
  }
}
