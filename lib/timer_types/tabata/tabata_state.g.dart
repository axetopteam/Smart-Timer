// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabata_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TabataState _$TabataStateFromJson(Map<String, dynamic> json) => TabataState(
      tabats: (json['tabats'] as List<dynamic>?)
          ?.map((e) => Tabata.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TabataStateToJson(TabataState instance) =>
    <String, dynamic>{
      'tabats': instance.tabats,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TabataState on TabataStoreBase, Store {
  Computed<int>? _$tabatsCountComputed;

  @override
  int get tabatsCount =>
      (_$tabatsCountComputed ??= Computed<int>(() => super.tabatsCount,
              name: 'TabataStoreBase.tabatsCount'))
          .value;

  late final _$TabataStoreBaseActionController =
      ActionController(name: 'TabataStoreBase', context: context);

  @override
  void setRounds(int tabataIndex, int value) {
    final _$actionInfo = _$TabataStoreBaseActionController.startAction(
        name: 'TabataStoreBase.setRounds');
    try {
      return super.setRounds(tabataIndex, value);
    } finally {
      _$TabataStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWorkTime(int tabataIndex, Duration duration) {
    final _$actionInfo = _$TabataStoreBaseActionController.startAction(
        name: 'TabataStoreBase.setWorkTime');
    try {
      return super.setWorkTime(tabataIndex, duration);
    } finally {
      _$TabataStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRestTime(int tabataIndex, Duration duration) {
    final _$actionInfo = _$TabataStoreBaseActionController.startAction(
        name: 'TabataStoreBase.setRestTime');
    try {
      return super.setRestTime(tabataIndex, duration);
    } finally {
      _$TabataStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRestAfterSet(int tabataIndex, Duration duration) {
    final _$actionInfo = _$TabataStoreBaseActionController.startAction(
        name: 'TabataStoreBase.setRestAfterSet');
    try {
      return super.setRestAfterSet(tabataIndex, duration);
    } finally {
      _$TabataStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTabata() {
    final _$actionInfo = _$TabataStoreBaseActionController.startAction(
        name: 'TabataStoreBase.addTabata');
    try {
      return super.addTabata();
    } finally {
      _$TabataStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteTabata(int tabataIndex) {
    final _$actionInfo = _$TabataStoreBaseActionController.startAction(
        name: 'TabataStoreBase.deleteTabata');
    try {
      return super.deleteTabata(tabataIndex);
    } finally {
      _$TabataStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tabatsCount: ${tabatsCount}
    ''';
  }
}
