// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'premium_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PremiumState on _PremiumState, Store {
  Computed<bool>? _$isPremiumActiveComputed;

  @override
  bool get isPremiumActive =>
      (_$isPremiumActiveComputed ??= Computed<bool>(() => super.isPremiumActive,
              name: '_PremiumState.isPremiumActive'))
          .value;

  late final _$_isPremiumActiveAtom =
      Atom(name: '_PremiumState._isPremiumActive', context: context);

  @override
  bool get _isPremiumActive {
    _$_isPremiumActiveAtom.reportRead();
    return super._isPremiumActive;
  }

  @override
  set _isPremiumActive(bool value) {
    _$_isPremiumActiveAtom.reportWrite(value, super._isPremiumActive, () {
      super._isPremiumActive = value;
    });
  }

  late final _$_PremiumStateActionController =
      ActionController(name: '_PremiumState', context: context);

  @override
  void updatePremiumStatus(AdaptyProfile profile) {
    final _$actionInfo = _$_PremiumStateActionController.startAction(
        name: '_PremiumState.updatePremiumStatus');
    try {
      return super.updatePremiumStatus(profile);
    } finally {
      _$_PremiumStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isPremiumActive: ${isPremiumActive}
    ''';
  }
}
