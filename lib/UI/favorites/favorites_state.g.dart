// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoritesState on _FavoritesState, Store {
  late final _$selectedTypeAtom =
      Atom(name: '_FavoritesState.selectedType', context: context);

  @override
  TimerType? get selectedType {
    _$selectedTypeAtom.reportRead();
    return super.selectedType;
  }

  @override
  set selectedType(TimerType? value) {
    _$selectedTypeAtom.reportWrite(value, super.selectedType, () {
      super.selectedType = value;
    });
  }

  late final _$_FavoritesStateActionController =
      ActionController(name: '_FavoritesState', context: context);

  @override
  void selectType(TimerType? newType) {
    final _$actionInfo = _$_FavoritesStateActionController.startAction(
        name: '_FavoritesState.selectType');
    try {
      return super.selectType(newType);
    } finally {
      _$_FavoritesStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedType: ${selectedType}
    ''';
  }
}
