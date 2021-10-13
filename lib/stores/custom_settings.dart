import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/round.dart';
import 'package:smart_timer/models/workout.dart';

part 'custom_settings.g.dart';

class CustomSettings = CustomSettingsBase with _$CustomSettings;

abstract class CustomSettingsBase with Store {
  @observable
  var roundsCount = 1;

  @observable
  ObservableList<Interval> intervals = ObservableList.of([
    Interval(
      duration: const Duration(minutes: 1),
      type: IntervalType.work,
      isCountdown: true,
    ),
    Interval(
      duration: const Duration(minutes: 2),
      type: IntervalType.work,
      isCountdown: true,
    ),
    Interval(
      duration: const Duration(minutes: 3),
      type: IntervalType.work,
      isCountdown: true,
    ),
  ]);

  @computed
  Workout get workout {
    final round = Round(intervals);
    List<Round> rounds = [];

    for (int i = 0; i < roundsCount; i++) {
      rounds.add(round);
    }
    return Workout.withLauchRound(rounds);
  }

  @action
  void setRounds(int value) {
    roundsCount = value;
  }

  @action
  void setInterval(int index, Duration duration) {
    if (index >= intervals.length) return;
    final interval = Interval(
      duration: duration,
      type: IntervalType.work,
      isCountdown: true,
    );
    intervals[index] = interval;
  }

  @action
  void addInterval() {
    final interval = intervals.last;
    intervals.add(interval);
    print(intervals.length);
  }

  @action
  void deleteInterval(int index) {
    if (intervals.length < 2 || index >= intervals.length) return;
    intervals.removeAt(index);
  }
}
