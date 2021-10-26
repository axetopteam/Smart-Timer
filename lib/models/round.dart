import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interfaces/interval_interface.dart';

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
    final lastKey = _currentInterval.indexes.keys.last;
    return _currentInterval.indexes
      ..addAll({
        lastKey + 1: [_intervalIndex + 1, intervalsCount]
      });
  }

  IntervalInterface get _currentInterval => intervals[_intervalIndex];

  @override
  bool get isEnded => intervals.last.isEnded;

  @override
  @computed
  Duration get currentTime => _currentInterval.currentTime;

  @override
  DateTime? get finishTimeUtc => intervals.last.finishTimeUtc;

  @override
  @action
  void tick(DateTime nowUtc) {
    if (isEnded) {
      return;
    }

    for (int i = _intervalIndex; i < intervalsCount - 1; i++) {
      if (!_currentInterval.isEnded) {
        break;
      }
      _intervalIndex++;
    }

    _currentInterval.tick(nowUtc);
  }

  @override
  @action
  void start(DateTime nowUtc) {
    intervals[0].start(nowUtc);
    print('start: $nowUtc');

    if (intervalsCount > 1) {
      for (int i = 1; i < intervalsCount; i++) {
        // print('last finish time: ${intervals[i - 1].finishTimeUtc!}');
        intervals[i].start((intervals[i - 1].finishTimeUtc!));
      }
    }

    // intervals.forEach((element) {
    //   print('rest duration: ${element.currentTime}');
    //   print('finish time: ${element.finishTimeUtc}');
    // });
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
