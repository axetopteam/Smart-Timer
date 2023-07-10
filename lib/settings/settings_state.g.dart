// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsState on _SettingsState, Store {
  late final _$soundOnAtom =
      Atom(name: '_SettingsState.soundOn', context: context);

  @override
  bool? get soundOn {
    _$soundOnAtom.reportRead();
    return super.soundOn;
  }

  @override
  set soundOn(bool? value) {
    _$soundOnAtom.reportWrite(value, super.soundOn, () {
      super.soundOn = value;
    });
  }

  late final _$saveSoundOnAsyncAction =
      AsyncAction('_SettingsState.saveSoundOn', context: context);

  @override
  Future<void> saveSoundOn(bool newValue) {
    return _$saveSoundOnAsyncAction.run(() => super.saveSoundOn(newValue));
  }

  @override
  String toString() {
    return '''
soundOn: ${soundOn}
    ''';
  }
}
