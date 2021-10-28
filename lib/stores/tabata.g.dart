// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabata.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TabataStore on TabataStoreBase, Store {
  Computed<Duration>? _$totalTimeComputed;

  @override
  Duration get totalTime =>
      (_$totalTimeComputed ??= Computed<Duration>(() => super.totalTime,
              name: 'TabataStoreBase.totalTime'))
          .value;
  Computed<WorkoutSet>? _$workoutComputed;

  @override
  WorkoutSet get workout =>
      (_$workoutComputed ??= Computed<WorkoutSet>(() => super.workout,
              name: 'TabataStoreBase.workout'))
          .value;

  final _$roundsCountAtom = Atom(name: 'TabataStoreBase.roundsCount');

  @override
  int get roundsCount {
    _$roundsCountAtom.reportRead();
    return super.roundsCount;
  }

  @override
  set roundsCount(int value) {
    _$roundsCountAtom.reportWrite(value, super.roundsCount, () {
      super.roundsCount = value;
    });
  }

  final _$workTimeAtom = Atom(name: 'TabataStoreBase.workTime');

  @override
  Interval get workTime {
    _$workTimeAtom.reportRead();
    return super.workTime;
  }

  @override
  set workTime(Interval value) {
    _$workTimeAtom.reportWrite(value, super.workTime, () {
      super.workTime = value;
    });
  }

  final _$restTimeAtom = Atom(name: 'TabataStoreBase.restTime');

  @override
  Interval get restTime {
    _$restTimeAtom.reportRead();
    return super.restTime;
  }

  @override
  set restTime(Interval value) {
    _$restTimeAtom.reportWrite(value, super.restTime, () {
      super.restTime = value;
    });
  }

  final _$showSetsAtom = Atom(name: 'TabataStoreBase.showSets');

  @override
  bool get showSets {
    _$showSetsAtom.reportRead();
    return super.showSets;
  }

  @override
  set showSets(bool value) {
    _$showSetsAtom.reportWrite(value, super.showSets, () {
      super.showSets = value;
    });
  }

  final _$setsCountAtom = Atom(name: 'TabataStoreBase.setsCount');

  @override
  int get setsCount {
    _$setsCountAtom.reportRead();
    return super.setsCount;
  }

  @override
  set setsCount(int value) {
    _$setsCountAtom.reportWrite(value, super.setsCount, () {
      super.setsCount = value;
    });
  }

  final _$restBetweenSetsAtom = Atom(name: 'TabataStoreBase.restBetweenSets');

  @override
  Interval get restBetweenSets {
    _$restBetweenSetsAtom.reportRead();
    return super.restBetweenSets;
  }

  @override
  set restBetweenSets(Interval value) {
    _$restBetweenSetsAtom.reportWrite(value, super.restBetweenSets, () {
      super.restBetweenSets = value;
    });
  }

  final _$TabataStoreBaseActionController =
      ActionController(name: 'TabataStoreBase');

  @override
  void setRounds(int value) {
    final _$actionInfo = _$TabataStoreBaseActionController.startAction(
        name: 'TabataStoreBase.setRounds');
    try {
      return super.setRounds(value);
    } finally {
      _$TabataStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWorkTime(Duration duration) {
    final _$actionInfo = _$TabataStoreBaseActionController.startAction(
        name: 'TabataStoreBase.setWorkTime');
    try {
      return super.setWorkTime(duration);
    } finally {
      _$TabataStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRestTime(Duration duration) {
    final _$actionInfo = _$TabataStoreBaseActionController.startAction(
        name: 'TabataStoreBase.setRestTime');
    try {
      return super.setRestTime(duration);
    } finally {
      _$TabataStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleShowSets() {
    final _$actionInfo = _$TabataStoreBaseActionController.startAction(
        name: 'TabataStoreBase.toggleShowSets');
    try {
      return super.toggleShowSets();
    } finally {
      _$TabataStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRestBetweenSets(Duration duration) {
    final _$actionInfo = _$TabataStoreBaseActionController.startAction(
        name: 'TabataStoreBase.setRestBetweenSets');
    try {
      return super.setRestBetweenSets(duration);
    } finally {
      _$TabataStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSetsCount(int value) {
    final _$actionInfo = _$TabataStoreBaseActionController.startAction(
        name: 'TabataStoreBase.setSetsCount');
    try {
      return super.setSetsCount(value);
    } finally {
      _$TabataStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
roundsCount: ${roundsCount},
workTime: ${workTime},
restTime: ${restTime},
showSets: ${showSets},
setsCount: ${setsCount},
restBetweenSets: ${restBetweenSets},
totalTime: ${totalTime},
workout: ${workout}
    ''';
  }
}
