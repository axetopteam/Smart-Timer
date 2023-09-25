// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amrap_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AmrapState on AmrapStateBase, Store {
  Computed<int>? _$amrapsCountComputed;

  @override
  int get amrapsCount =>
      (_$amrapsCountComputed ??= Computed<int>(() => super.amrapsCount,
              name: 'AmrapStateBase.amrapsCount'))
          .value;

  late final _$AmrapStateBaseActionController =
      ActionController(name: 'AmrapStateBase', context: context);

  @override
  void setWorkTime(int amrapIndex, Duration duration) {
    final _$actionInfo = _$AmrapStateBaseActionController.startAction(
        name: 'AmrapStateBase.setWorkTime');
    try {
      return super.setWorkTime(amrapIndex, duration);
    } finally {
      _$AmrapStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRestTime(int amrapIndex, Duration duration) {
    final _$actionInfo = _$AmrapStateBaseActionController.startAction(
        name: 'AmrapStateBase.setRestTime');
    try {
      return super.setRestTime(amrapIndex, duration);
    } finally {
      _$AmrapStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addAmrap() {
    final _$actionInfo = _$AmrapStateBaseActionController.startAction(
        name: 'AmrapStateBase.addAmrap');
    try {
      return super.addAmrap();
    } finally {
      _$AmrapStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteAmrap(int amrapIndex) {
    final _$actionInfo = _$AmrapStateBaseActionController.startAction(
        name: 'AmrapStateBase.deleteAmrap');
    try {
      return super.deleteAmrap(amrapIndex);
    } finally {
      _$AmrapStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
amrapsCount: ${amrapsCount}
    ''';
  }
}
