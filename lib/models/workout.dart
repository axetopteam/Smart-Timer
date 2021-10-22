import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/set.dart';
import 'package:smart_timer/stores/timer_status.dart';

part 'workout.g.dart';

class Workout = WorkoutBase with _$Workout;

abstract class WorkoutBase with Store {
  WorkoutBase(this.sets);

  final List<WorkoutSet> sets;

  final stream = Stream.periodic(const Duration(seconds: 1), (x) => x);
  StreamSubscription? timerSubscription;

  @observable
  var status = TimerStatus.stop;

  //set info
  @observable
  int _setIndex = 0;

  @computed
  int get setIndex => _setIndex;

  @computed
  int get setsCount => sets.length;

  //round info
  @computed
  int get roundIndex => _currentSet.roundIndex;

  @computed
  int get roundsCount => _currentSet.roundsCount;

  //interval info
  @computed
  int get intervalIndex => _currentSet.intervalIndex;

  @computed
  int get intervalsCount => _currentSet.intervalsCount;

  @computed
  WorkoutSet get _currentSet => sets[_setIndex];

  @observable
  bool isEnded = false;

  @computed
  Duration get currentTime => _currentSet.currentTime;

  @action
  void tick() {
    if (isEnded) return;
    if (_currentSet.isEnded) {
      if (_setIndex == setsCount - 1) {
        isEnded = true;
        close();
        status = TimerStatus.done;
      } else {
        _setIndex++;
      }
    }
    _currentSet.tick();
  }

  @action
  void start() {
    timerSubscription?.cancel();
    status = TimerStatus.run;
    timerSubscription = stream.listen((_) {
      tick();
    });
  }

  @action
  void pause() {
    // timer?.cancel();
    timerSubscription?.pause();
    status = TimerStatus.pause;
  }

  @action
  void resume() {
    status = TimerStatus.run;
    timerSubscription?.resume();
  }

  @action
  void close() {
    timerSubscription?.cancel();
  }

  // factory WorkoutBase.withCountdownInterval(List<Round> rounds) {
  //   final firstRoundIntervals = ObservableList<Interval>.of(rounds.first.intervals);
  //   final launchInterval = Interval(duration: const Duration(seconds: 4), type: IntervalType.countdown);
  //   firstRoundIntervals.insert(
  //     0,
  //     launchInterval,
  //   );
  //   rounds[0] = Round(firstRoundIntervals);

  //   return Workout._(ObservableList.of([
  //     WorkoutSet(
  //       ObservableList.of(rounds),
  //     ),
  //   ]));
  // }

  // factory WorkoutBase.withCountdownInterval2(List<WorkoutSet> sets) {
  //   final firstSetRounds = ObservableList<Round>.of(sets.first.rounds);
  //   final firstRoundIntervals = ObservableList<Interval>.of(firstSetRounds.first.intervals);
  //   final launchInterval = Interval(duration: const Duration(seconds: 4), type: IntervalType.countdown);
  //   firstRoundIntervals.insert(
  //     0,
  //     launchInterval,
  //   );
  //   final newRound = Round(firstRoundIntervals);
  //   firstSetRounds[0] = newRound;
  //   final newSet = WorkoutSet(firstSetRounds);

  //   sets[0] = newSet;

  //   return Workout._(
  //     ObservableList<WorkoutSet>.of(sets),
  //   );
  // }
}
