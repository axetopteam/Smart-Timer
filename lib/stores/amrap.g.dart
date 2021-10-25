// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amrap.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Amrap on AmrapBase, Store {
  final _$workTimeAtom = Atom(name: 'AmrapBase.workTime');

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

  final _$AmrapBaseActionController = ActionController(name: 'AmrapBase');

  @override
  void setWorkTime(Duration duration) {
    final _$actionInfo =
        _$AmrapBaseActionController.startAction(name: 'AmrapBase.setWorkTime');
    try {
      return super.setWorkTime(duration);
    } finally {
      _$AmrapBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
workTime: ${workTime}
    ''';
  }
}
