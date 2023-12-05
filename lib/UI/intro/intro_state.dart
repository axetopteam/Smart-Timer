import 'package:mobx/mobx.dart';

part 'intro_state.g.dart';

// ignore: library_private_types_in_public_api
class IntroState = _IntroState with _$IntroState;

abstract class _IntroState with Store {
  @observable
  RoleOption? selectedRole;

  @action
  void selectRole(RoleOption newRole) {
    selectedRole = newRole;
  }
}

enum RoleOption { coach, onMyOwn }
