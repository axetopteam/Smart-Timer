import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/interfaces/descriptionable.dart';
import 'package:smart_timer/models/interfaces/interval_interface.dart';
import 'package:smart_timer/models/workout_interval.dart';
import 'package:smart_timer/services/audio_service.dart';

part 'workout_set.g.dart';

class WorkoutSet = WorkoutSetBase with _$WorkoutSet;

abstract class WorkoutSetBase with Store implements IntervalInterface, Descriptionable {
  WorkoutSetBase(List<IntervalInterface> setsList, {this.descriptionSolver}) : sets = ObservableList.of(setsList);

  final ObservableList<IntervalInterface> sets;

  final String Function(int)? descriptionSolver;

  //interval info
  @observable
  int _currentSetIndex = 0;

  int get currentSetIndex => _currentSetIndex;

  int get setsCount => sets.length;

  IntervalInterface get _currentSet => sets[_currentSetIndex];

  @override
  @computed
  Duration? get currentTime => _currentSet.currentTime;

  @override
  DateTime? get finishTimeUtc => sets.last.finishTimeUtc;

  @override
  WorkoutInterval get currentInterval => _currentSet.currentInterval as WorkoutInterval;

  @override
  WorkoutInterval? get nextInterval {
    final next = _currentSet.nextInterval;

    if (next != null) {
      return next as WorkoutInterval;
    }

    if (next == null && _currentSetIndex < setsCount - 1) {
      return sets[_currentSetIndex + 1].currentInterval as WorkoutInterval;
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
    for (var interval in sets) {
      interval.pause();
    }
  }

  @override
  @action
  void tick(DateTime nowUtc) {
    if (isEnded) {
      return;
    }

    _currentSet.tick(nowUtc);

    for (int i = _currentSetIndex; i < setsCount - 1; i++) {
      if (!_currentSet.isEnded) {
        break;
      }
      _currentSetIndex++;
    }
  }

  @override
  WorkoutSet copy() {
    final copyList = List.generate(setsCount, (index) => sets[index].copy());
    return WorkoutSet(copyList, descriptionSolver: descriptionSolver);
  }

  @override
  String toString() {
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < setsCount; i++) {
      buffer.write('Round ${i + 1} \n');
      final set = sets[i];
      if ((set is! WorkoutInterval)) buffer.write('\n');
      buffer.write(set.toString());

      buffer.write('\n');
    }

    return buffer.toString();
  }

  @override
  String get currentStateDescription {
    StringBuffer buffer = StringBuffer();
    buffer.write(descriptionSolver?.call(_currentSetIndex + 1) ?? '');
    final childDescription =
        _currentSet is Descriptionable ? (_currentSet as Descriptionable).currentStateDescription : null;
    if (childDescription != null) buffer.write('\n$childDescription');
    return buffer.toString();
  }
}
