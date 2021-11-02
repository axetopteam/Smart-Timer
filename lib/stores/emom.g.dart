// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emom.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Emom on EmomBase, Store {
  final _$roundsCountAtom = Atom(name: 'EmomBase.roundsCount');

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

  final _$workTimeAtom = Atom(name: 'EmomBase.workTime');

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

  final _$showSetsAtom = Atom(name: 'EmomBase.showSets');

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

  final _$setsCountAtom = Atom(name: 'EmomBase.setsCount');

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

  final _$restBetweenSetsAtom = Atom(name: 'EmomBase.restBetweenSets');

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

  final _$EmomBaseActionController = ActionController(name: 'EmomBase');

  @override
  void setRounds(int value) {
    final _$actionInfo =
        _$EmomBaseActionController.startAction(name: 'EmomBase.setRounds');
    try {
      return super.setRounds(value);
    } finally {
      _$EmomBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWorkTime(Duration duration) {
    final _$actionInfo =
        _$EmomBaseActionController.startAction(name: 'EmomBase.setWorkTime');
    try {
      return super.setWorkTime(duration);
    } finally {
      _$EmomBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleShowSets() {
    final _$actionInfo =
        _$EmomBaseActionController.startAction(name: 'EmomBase.toggleShowSets');
    try {
      return super.toggleShowSets();
    } finally {
      _$EmomBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRestBetweenSets(Duration duration) {
    final _$actionInfo = _$EmomBaseActionController.startAction(
        name: 'EmomBase.setRestBetweenSets');
    try {
      return super.setRestBetweenSets(duration);
    } finally {
      _$EmomBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSetsCount(int value) {
    final _$actionInfo =
        _$EmomBaseActionController.startAction(name: 'EmomBase.setSetsCount');
    try {
      return super.setSetsCount(value);
    } finally {
      _$EmomBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
roundsCount: ${roundsCount},
workTime: ${workTime},
showSets: ${showSets},
setsCount: ${setsCount},
restBetweenSets: ${restBetweenSets}
    ''';
  }
}
