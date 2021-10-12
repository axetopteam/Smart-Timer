import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/round.dart';
import 'package:smart_timer/models/workout.dart';

part 'afap.g.dart';

class Afap = AfapBase with _$Afap;

abstract class AfapBase with Store {
  @observable
  Interval workTime = Interval(
    duration: const Duration(minutes: 10),
    type: IntervalType.work,
    isCountdown: false,
  );

  @computed
  Workout get workout {
    final round = Round([workTime]);

    return Workout.withLauchRound([round]);
  }

  @action
  void setTimeCap(Duration? duration) {
    workTime = Interval(
      duration: duration,
      type: IntervalType.work,
      isCountdown: false,
    );
  }
}
