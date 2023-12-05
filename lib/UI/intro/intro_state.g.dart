// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intro_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$IntroState on _IntroState, Store {
  late final _$selectedRoleAtom =
      Atom(name: '_IntroState.selectedRole', context: context);

  @override
  RoleOption? get selectedRole {
    _$selectedRoleAtom.reportRead();
    return super.selectedRole;
  }

  @override
  set selectedRole(RoleOption? value) {
    _$selectedRoleAtom.reportWrite(value, super.selectedRole, () {
      super.selectedRole = value;
    });
  }

  late final _$_IntroStateActionController =
      ActionController(name: '_IntroState', context: context);

  @override
  void selectRole(RoleOption newRole) {
    final _$actionInfo = _$_IntroStateActionController.startAction(
        name: '_IntroState.selectRole');
    try {
      return super.selectRole(newRole);
    } finally {
      _$_IntroStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedRole: ${selectedRole}
    ''';
  }
}
