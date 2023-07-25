// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adapty_profile_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AdaptyProfileState on _AdaptyProfileState, Store {
  Computed<bool>? _$isPremiumActiveComputed;

  @override
  bool get isPremiumActive =>
      (_$isPremiumActiveComputed ??= Computed<bool>(() => super.isPremiumActive,
              name: '_AdaptyProfileState.isPremiumActive'))
          .value;

  late final _$profileAtom =
      Atom(name: '_AdaptyProfileState.profile', context: context);

  @override
  AdaptyProfile? get profile {
    _$profileAtom.reportRead();
    return super.profile;
  }

  @override
  set profile(AdaptyProfile? value) {
    _$profileAtom.reportWrite(value, super.profile, () {
      super.profile = value;
    });
  }

  late final _$_AdaptyProfileStateActionController =
      ActionController(name: '_AdaptyProfileState', context: context);

  @override
  void updatePremiumStatus(AdaptyProfile profile) {
    final _$actionInfo = _$_AdaptyProfileStateActionController.startAction(
        name: '_AdaptyProfileState.updatePremiumStatus');
    try {
      return super.updatePremiumStatus(profile);
    } finally {
      _$_AdaptyProfileStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
profile: ${profile},
isPremiumActive: ${isPremiumActive}
    ''';
  }
}
