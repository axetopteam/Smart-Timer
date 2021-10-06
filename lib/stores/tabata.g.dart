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
  Computed<List<Duration>>? _$scheduleComputed;

  @override
  List<Duration> get schedule =>
      (_$scheduleComputed ??= Computed<List<Duration>>(() => super.schedule,
              name: 'TabataStoreBase.schedule'))
          .value;

  final _$roundsAtom = Atom(name: 'TabataStoreBase.rounds');

  @override
  int get rounds {
    _$roundsAtom.reportRead();
    return super.rounds;
  }

  @override
  set rounds(int value) {
    _$roundsAtom.reportWrite(value, super.rounds, () {
      super.rounds = value;
    });
  }

  final _$workTimeAtom = Atom(name: 'TabataStoreBase.workTime');

  @override
  Duration get workTime {
    _$workTimeAtom.reportRead();
    return super.workTime;
  }

  @override
  set workTime(Duration value) {
    _$workTimeAtom.reportWrite(value, super.workTime, () {
      super.workTime = value;
    });
  }

  final _$restTimeAtom = Atom(name: 'TabataStoreBase.restTime');

  @override
  Duration get restTime {
    _$restTimeAtom.reportRead();
    return super.restTime;
  }

  @override
  set restTime(Duration value) {
    _$restTimeAtom.reportWrite(value, super.restTime, () {
      super.restTime = value;
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
  void setWorkTime(Duration value) {
    final _$actionInfo = _$TabataStoreBaseActionController.startAction(
        name: 'TabataStoreBase.setWorkTime');
    try {
      return super.setWorkTime(value);
    } finally {
      _$TabataStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRestTime(Duration value) {
    final _$actionInfo = _$TabataStoreBaseActionController.startAction(
        name: 'TabataStoreBase.setRestTime');
    try {
      return super.setRestTime(value);
    } finally {
      _$TabataStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
rounds: ${rounds},
workTime: ${workTime},
restTime: ${restTime},
totalTime: ${totalTime},
schedule: ${schedule}
    ''';
  }
}
