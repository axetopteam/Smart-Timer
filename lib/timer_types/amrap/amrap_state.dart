import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/workout_interval.dart';
import 'package:smart_timer/models/workout_interval_type.dart';
import 'package:smart_timer/models/workout_set.dart';

part 'amrap_state.g.dart';

class AmrapState extends AmrapStateBase with _$AmrapState {
  AmrapState({ObservableList<ObservableList<Duration>>? rounds}) : super(rounds: rounds);

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

  factory AmrapState.fromJson(Map<String, dynamic> json) {
    ObservableList<ObservableList<Duration>> rounds = ObservableList<ObservableList<Duration>>();

    for (int i = 0; i < json.length; i++) {
      ObservableList<Duration> round = ObservableList.of([
        Duration(seconds: json['$i']['work']),
        Duration(seconds: json['$i']['rest']),
      ]);
      rounds.add(round);
    }

    return AmrapState(rounds: rounds);
  }
}

abstract class AmrapStateBase with Store {
  static final initialRound = ObservableList.of(
    [
      ObservableList.of(
        [
          const Duration(minutes: 10),
          const Duration(minutes: 1),
        ],
      ),
    ],
  );

  AmrapStateBase({ObservableList<ObservableList<Duration>>? rounds}) : rounds = rounds ?? initialRound;

  @observable
  ObservableList<ObservableList<Duration>> rounds;

  @computed
  int get roundsCound => rounds.length;

  @action
  void addRound() {
    final ObservableList<Duration> newRound = rounds.isNotEmpty ? ObservableList.of(rounds.last) : initialRound.first;
    rounds.add(newRound);
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
          WorkoutInterval(type: WorkoutIntervalType.work, duration: rounds[i][0], isLast: i == rounds.length - 1),
          if (i != rounds.length - 1) WorkoutInterval(type: WorkoutIntervalType.rest, duration: rounds[i][1]),
        ],
      );
      roundsSets.add(round);
    }

    return WorkoutSet(roundsSets, descriptionSolver: _descriptionSolver);
  }

  String _descriptionSolver(int currentAmrapIndex) {
    return 'AMRAP $currentAmrapIndex/${rounds.length}';
  }
}
