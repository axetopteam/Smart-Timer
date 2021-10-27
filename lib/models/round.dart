import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interfaces/interval_interface.dart';
import 'package:smart_timer/models/interval.dart';

part 'round.g.dart';

class Round = RoundBase with _$Round;

abstract class RoundBase with Store implements IntervalInterface {
  RoundBase(this.intervals);

  final List<IntervalInterface> intervals;

  //interval info
  @observable
  int _intervalIndex = 0;

  @computed
  int get intervalIndex => _intervalIndex;

  @computed
  int get intervalsCount => intervals.length;

  @override
  @computed
  Map<int, List<int>> get indexes {
    final lastKey = _currentRound.indexes.keys.last;
    return _currentRound.indexes
      ..addAll({
        lastKey + 1: [_intervalIndex + 1, intervalsCount]
      });
  }

  IntervalInterface get _currentRound => intervals[_intervalIndex];

  @override
  Interval get currentInterval => _currentRound.currentInterval as Interval;

  @override
  Interval? get nextInterval {
    final next = _currentRound.nextInterval;

    if (next != null) {
      return next as Interval;
    }

    if (next == null && _intervalIndex < intervalsCount - 1) {
      return intervals[_intervalIndex + 1].currentInterval as Interval;
    }
  }

  @override
  bool get isEnded => intervals.last.isEnded;

  @override
  @computed
  Duration? get currentTime => _currentRound.currentTime;

  @override
  DateTime? get finishTimeUtc => intervals.last.finishTimeUtc;

  @action
  void setDuration() {
    currentInterval.setDuration();
    if (nextInterval?.isReverse ?? false) {
      nextInterval?.setDuration(newDuration: currentInterval.duration);
    }
    setStartTime();
  }

  @override
  @action
  void tick(DateTime nowUtc) {
    if (isEnded) {
      return;
    }

    for (int i = _intervalIndex; i < intervalsCount - 1; i++) {
      if (!_currentRound.isEnded) {
        break;
      }
      _intervalIndex++;
    }

    _currentRound.tick(nowUtc);
  }

  @override
  @action
  void start(DateTime nowUtc) {
    intervals[0].start(nowUtc);
    setStartTime();
  }

  void setStartTime() {
    if (intervalsCount > 1) {
      for (int i = 1; i < intervalsCount; i++) {
        if (intervals[i - 1].finishTimeUtc == null) {
          break;
        }
        intervals[i].start((intervals[i - 1].finishTimeUtc!));
      }
    }
  }

  @override
  @action
  void pause() {
    intervals.forEach((interval) => interval.pause());
  }

  @override
  Round copy() {
    final copyList = List.generate(intervalsCount, (index) => intervals[index].copy());
    return Round(copyList);
  }

  @override
  String description() {
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < intervalsCount; i++) {
      buffer.write('Round $i \n');
      buffer.write(intervals[i].description());
      buffer.write('\n');
    }

    return buffer.toString();
  }
}
