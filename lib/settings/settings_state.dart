import 'package:mobx/mobx.dart';
import 'package:smart_timer/services/app_properties.dart';

part 'settings_state.g.dart';

// ignore: library_private_types_in_public_api
class SettingsState = _SettingsState with _$SettingsState;

abstract class _SettingsState with Store {
  _SettingsState() {
    _initializeValues();
  }

  final _properties = AppProperties();

  @observable
  bool? soundOn;

  _initializeValues() {
    soundOn = _properties.soundOn;
  }

  @action
  Future<void> saveSoundOn(bool newValue) async {
    final oldValue = soundOn;
    soundOn = null;
    final res = await _properties.saveSoundOn(newValue);
    if (res) {
      soundOn = newValue;
    } else {
      soundOn = oldValue;
    }
  }
}
