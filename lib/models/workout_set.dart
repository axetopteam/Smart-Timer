import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interfaces/interval_interface.dart';
import 'package:smart_timer/models/interval.dart';
import 'package:smart_timer/services/audio_service.dart';

part 'workout_set.g.dart';

class WorkoutSet extends WorkoutSetBase with _$WorkoutSet {
  WorkoutSet(List<IntervalInterface> setsList) : super(setsList);
}

abstract class WorkoutSetBase with Store implements IntervalInterface {
  WorkoutSetBase(List<IntervalInterface> setsList) : sets = ObservableList.of(setsList);

  final ObservableList<IntervalInterface> sets;

  //interval info
  @observable
  int _setIndex = 0;

  int get setIndex => _setIndex;

  int get setsCount => sets.length;

  IntervalInterface get _currentSet => sets[_setIndex];

  @override
  @computed
  Duration? get currentTime => _currentSet.currentTime;

  @override
  DateTime? get finishTimeUtc => sets.last.finishTimeUtc;

  @override
  @computed
  Map<int, List<int>> get indexes {
    final lastKey = _currentSet.indexes.keys.last;
    return _currentSet.indexes
      ..addAll({
        lastKey + 1: [_setIndex + 1, setsCount]
      });
  }

  @override
  Interval get currentInterval => _currentSet.currentInterval as Interval;

  @override
  Interval? get nextInterval {
    final next = _currentSet.nextInterval;

    if (next != null) {
      return next as Interval;
    }

    if (next == null && _setIndex < setsCount - 1) {
      return sets[_setIndex + 1].currentInterval as Interval;
    }
    return null;
  }

  @override
  Map<DateTime, SoundType> get reminders {
    Map<DateTime, SoundType> reminders = {};
    for (int i = 0; i < setsCount; i++) {
      reminders.addAll(sets[i].reminders);
    }
    return reminders;
  }

  @override
  @action
  void setDuration({Duration? newDuration}) {
    currentInterval.setDuration();
    final next = nextInterval;
    if (next != null && next.isReverse) {
      next.setDuration(newDuration: currentInterval.duration! * next.reverseRatio);
    }
    setStartTime();
  }

  @override
  bool get isEnded => sets.last.isEnded;

  @override
  @action
  void start(DateTime nowUtc) {
    sets[0].start(nowUtc);
    if (setsCount > 1) {
      for (int i = 1; i < setsCount; i++) {
        if (sets[i - 1].finishTimeUtc == null) {
          break;
        }
        sets[i].start((sets[i - 1].finishTimeUtc!));
      }
    }
  }

  void setStartTime() {
    if (!sets[0].isEnded && sets[0] is WorkoutSet) {
      (sets[0] as WorkoutSet).setStartTime();
    }

    if (setsCount > 1) {
      for (int i = 1; i < setsCount; i++) {
        if (sets[i - 1].finishTimeUtc == null) {
          break;
        }
        sets[i].start((sets[i - 1].finishTimeUtc!));
      }
    }
  }

  @override
  @action
  void pause() {
    sets.forEach((interval) => interval.pause());
  }

  @override
  @action
  void tick(DateTime nowUtc) {
    if (isEnded) {
      return;
    }

    _currentSet.tick(nowUtc);

    for (int i = _setIndex; i < setsCount - 1; i++) {
      if (!_currentSet.isEnded) {
        break;
      }
      _setIndex++;
    }
  }

  @override
  WorkoutSet copy() {
    final copyList = List.generate(setsCount, (index) => sets[index].copy());
    return WorkoutSet(copyList);
  }

  @override
  String description() {
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < setsCount; i++) {
      buffer.write('Round ${i + 1} \n');
      final set = sets[i];
      if ((set is! Interval)) buffer.write('\n');
      buffer.write(sets[i].description());

      buffer.write('\n');
    }

    return buffer.toString();
  }
}
