import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/round.dart';

part 'set.g.dart';

class WorkoutSet = WorkoutSetBase with _$WorkoutSet;

abstract class WorkoutSetBase with Store {
  WorkoutSetBase(this.rounds);

  final List<Round> rounds;

  //round info
  @observable
  int _roundIndex = 0;

  @computed
  int get roundIndex => _roundIndex;

  @computed
  int get roundsCount => rounds.length;

  //interval info
  @computed
  int get intervalIndex => _currentRound.intervalIndex;

  @computed
  int get intervalsCount => _currentRound.intervalsCount;
  //

  @computed
  Round get _currentRound => rounds[_roundIndex];

  @observable
  bool isEnded = false;

  @computed
  Duration get currentTime => _currentRound.currentTime;

  @action
  void tick() {
    if (isEnded) return;
    if (_currentRound.isEnded) {
      if (_roundIndex == roundsCount - 1) {
        isEnded = true;
      } else {
        _roundIndex++;
      }
    }
    _currentRound.tick();
  }
}
