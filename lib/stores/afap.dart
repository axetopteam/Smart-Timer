import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/round.dart';
// import 'package:smart_timer/models/set.dart';
// import 'package:smart_timer/models/workout.dart';

part 'afap.g.dart';

class Afap = AfapBase with _$Afap;

abstract class AfapBase with Store {
  @observable
  Interval workTime = Interval(
    duration: null,
    type: IntervalType.work,
    isCountdown: false,
  );

  final rest = Interval(
    duration: null,
    type: IntervalType.rest,
    isCountdown: true,
    isReverse: true,
  );

  @computed
  Round get workout {
    final round = Round(
      [
        workTime,
        rest,
      ],
    );
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
