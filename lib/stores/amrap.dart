import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/models/interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';

part 'amrap.g.dart';

class Amrap extends AmrapBase with _$Amrap {
  Amrap({ObservableList<ObservableList<Duration>>? rounds}) : super(rounds: rounds);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    for (int i = 0; i < rounds.length; i++) {
      final roundJson = {
        'work': rounds[i][0].inSeconds,
        'rest': rounds[i][1].inSeconds,
      };
      json.addAll({'$i': roundJson});
    }
    return json;
  }

  factory Amrap.fromJson(Map<String, dynamic> json) {
    ObservableList<ObservableList<Duration>> rounds = ObservableList<ObservableList<Duration>>();

    for (int i = 0; i < json.length; i++) {
      ObservableList<Duration> round = ObservableList.of([
        Duration(seconds: json['$i']['work']),
        Duration(seconds: json['$i']['rest']),
      ]);
      rounds.add(round);
    }

    return Amrap(rounds: rounds);
  }
}

abstract class AmrapBase with Store {
  AmrapBase({ObservableList<ObservableList<Duration>>? rounds})
      : rounds = rounds ??
            ObservableList.of(
              [
                ObservableList.of(
                  [
                    const Duration(minutes: 10),
                    const Duration(minutes: 1),
                  ],
                ),
              ],
            );
  @observable
  ObservableList<ObservableList<Duration>> rounds;

  @computed
  int get roundsCound => rounds.length;

  @action
  void addRound() {
    final lastRoundCopy = ObservableList.of(rounds.last);
    rounds.add(lastRoundCopy);
  }

  @action
  void deleteRound(int roundIndex) {
    rounds.removeAt(roundIndex);
  }

  @action
  void setInterval(int roundIndex, int intervalIndex, Duration duration) {
    if (roundIndex >= rounds.length || intervalIndex >= rounds[roundIndex].length) return;

    rounds[roundIndex][intervalIndex] = duration;
  }

  @computed
  WorkoutSet get workout {
    final List<WorkoutSet> roundsSets = [];
    for (int i = 0; i < rounds.length; i++) {
      final round = WorkoutSet(
        [
          Interval(type: IntervalType.work, duration: rounds[i][0]),
          if (i != rounds.length - 1) Interval(type: IntervalType.rest, duration: rounds[i][1]),
        ],
      );
      roundsSets.add(round);
    }

    return WorkoutSet(roundsSets).copy();
  }
}
