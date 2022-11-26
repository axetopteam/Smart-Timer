// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customized_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CustomizedState on CustomizedStateBase, Store {
  late final _$roundsCountsAtom =
      Atom(name: 'CustomizedStateBase.roundsCounts', context: context);

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

  late final _$setsAtom =
      Atom(name: 'CustomizedStateBase.sets', context: context);

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

  late final _$CustomizedStateBaseActionController =
      ActionController(name: 'CustomizedStateBase', context: context);

  @override
  void setRounds(int setIndex, int value) {
    final _$actionInfo = _$CustomizedStateBaseActionController.startAction(
        name: 'CustomizedStateBase.setRounds');
    try {
      return super.setRounds(setIndex, value);
    } finally {
      _$CustomizedStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setInterval(int setIndex, int intervalIndex, Duration duration) {
    final _$actionInfo = _$CustomizedStateBaseActionController.startAction(
        name: 'CustomizedStateBase.setInterval');
    try {
      return super.setInterval(setIndex, intervalIndex, duration);
    } finally {
      _$CustomizedStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addRound() {
    final _$actionInfo = _$CustomizedStateBaseActionController.startAction(
        name: 'CustomizedStateBase.addRound');
    try {
      return super.addRound();
    } finally {
      _$CustomizedStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteRound(int setIndex) {
    final _$actionInfo = _$CustomizedStateBaseActionController.startAction(
        name: 'CustomizedStateBase.deleteRound');
    try {
      return super.deleteRound(setIndex);
    } finally {
      _$CustomizedStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addInterval(int setIndex) {
    final _$actionInfo = _$CustomizedStateBaseActionController.startAction(
        name: 'CustomizedStateBase.addInterval');
    try {
      return super.addInterval(setIndex);
    } finally {
      _$CustomizedStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteInterval(int setIndex, int intervalIndex) {
    final _$actionInfo = _$CustomizedStateBaseActionController.startAction(
        name: 'CustomizedStateBase.deleteInterval');
    try {
      return super.deleteInterval(setIndex, intervalIndex);
    } finally {
      _$CustomizedStateBaseActionController.endAction(_$actionInfo);
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
