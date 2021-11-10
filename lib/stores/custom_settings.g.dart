// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_settings.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CustomSettings on CustomSettingsBase, Store {
  final _$roundsCountsAtom = Atom(name: 'CustomSettingsBase.roundsCounts');

  @override
  ObservableList<int> get roundsCounts {
    _$roundsCountsAtom.reportRead();
    return super.roundsCounts;
  }

  @override
  set roundsCounts(ObservableList<int> value) {
    _$roundsCountsAtom.reportWrite(value, super.roundsCounts, () {
      super.roundsCounts = value;
    });
  }

  final _$setsAtom = Atom(name: 'CustomSettingsBase.sets');

  @override
  ObservableList<ObservableList<Duration>> get sets {
    _$setsAtom.reportRead();
    return super.sets;
  }

  @override
  set sets(ObservableList<ObservableList<Duration>> value) {
    _$setsAtom.reportWrite(value, super.sets, () {
      super.sets = value;
    });
  }

  final _$CustomSettingsBaseActionController =
      ActionController(name: 'CustomSettingsBase');

  @override
  void setRounds(int setIndex, int value) {
    final _$actionInfo = _$CustomSettingsBaseActionController.startAction(
        name: 'CustomSettingsBase.setRounds');
    try {
      return super.setRounds(setIndex, value);
    } finally {
      _$CustomSettingsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setInterval(int setIndex, int intervalIndex, Duration duration) {
    final _$actionInfo = _$CustomSettingsBaseActionController.startAction(
        name: 'CustomSettingsBase.setInterval');
    try {
      return super.setInterval(setIndex, intervalIndex, duration);
    } finally {
      _$CustomSettingsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addRound() {
    final _$actionInfo = _$CustomSettingsBaseActionController.startAction(
        name: 'CustomSettingsBase.addRound');
    try {
      return super.addRound();
    } finally {
      _$CustomSettingsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteRound(int setIndex) {
    final _$actionInfo = _$CustomSettingsBaseActionController.startAction(
        name: 'CustomSettingsBase.deleteRound');
    try {
      return super.deleteRound(setIndex);
    } finally {
      _$CustomSettingsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addInterval(int setIndex) {
    final _$actionInfo = _$CustomSettingsBaseActionController.startAction(
        name: 'CustomSettingsBase.addInterval');
    try {
      return super.addInterval(setIndex);
    } finally {
      _$CustomSettingsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteInterval(int setIndex, int intervalIndex) {
    final _$actionInfo = _$CustomSettingsBaseActionController.startAction(
        name: 'CustomSettingsBase.deleteInterval');
    try {
      return super.deleteInterval(setIndex, intervalIndex);
    } finally {
      _$CustomSettingsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
roundsCounts: ${roundsCounts},
sets: ${sets}
    ''';
  }
}
