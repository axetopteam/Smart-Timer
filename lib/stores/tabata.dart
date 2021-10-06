import 'package:mobx/mobx.dart';
import 'package:smart_timer/application/models/interval.dart';
import 'package:smart_timer/application/models/interval_type.dart';

part 'tabata.g.dart';

class TabataStore = TabataStoreBase with _$TabataStore;

abstract class TabataStoreBase with Store {
  @observable
  var rounds = 8;

  @observable
  var workTime = Interval(
    duration: const Duration(seconds: 20),
    type: IntervalType.work,
  );

  @observable
  var restTime = Interval(
    duration: const Duration(seconds: 10),
    type: IntervalType.rest,
  );

  @computed
  Duration get totalTime => (workTime.duration + restTime.duration) * rounds;

  @computed
  List<Interval> get schedule {
    List<Interval> timing = [
      Interval(
        duration: const Duration(seconds: 10),
        type: IntervalType.prelaunch,
      )
    ];
    for (int i = 0; i < rounds; i++) {
      timing.addAll([workTime, restTime]);
    }
    return timing;
  }

  @action
  void setRounds(int value) {
    rounds = value;
  }

  @action
  void setWorkTime(Duration duration) {
    workTime = Interval(
      duration: duration,
      type: IntervalType.work,
    );
  }

  @action
  void setRestTime(Duration duration) {
    restTime = Interval(
      duration: duration,
      type: IntervalType.rest,
    );
  }
}
