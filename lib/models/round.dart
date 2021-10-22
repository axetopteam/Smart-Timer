import 'package:mobx/mobx.dart';
import 'interval.dart';

part 'round.g.dart';

class Round = RoundBase with _$Round;

abstract class RoundBase with Store {
  RoundBase(this.intervals);

  final List<Interval> intervals;

  //interval info
  @observable
  int _intervalIndex = 0;

  @computed
  int get intervalIndex => _intervalIndex;

  @computed
  int get intervalsCount => intervals.length;

  //

  @computed
  Interval get _currentInterval => intervals[_intervalIndex];

  @observable
  bool isEnded = false;

  @computed
  Duration get currentTime => _currentInterval.currentTime;

  @action
  void tick() {
    if (isEnded) return;
    if (_currentInterval.isEnded) {
      if (_intervalIndex == intervalsCount - 1) {
        isEnded = true;
      } else {
        _intervalIndex++;
      }
    }
    _currentInterval.tick();
  }
}
