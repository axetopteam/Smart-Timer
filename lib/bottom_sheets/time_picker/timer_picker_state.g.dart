// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_picker_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TimerPickerState on TimerPickerStateBase, Store {
  late final _$minutesAtom =
      Atom(name: 'TimerPickerStateBase.minutes', context: context);

  @override
  int? get minutes {
    _$minutesAtom.reportRead();
    return super.minutes;
  }

  @override
  set minutes(int? value) {
    _$minutesAtom.reportWrite(value, super.minutes, () {
      super.minutes = value;
    });
  }

  late final _$secondsAtom =
      Atom(name: 'TimerPickerStateBase.seconds', context: context);

  @override
  int? get seconds {
    _$secondsAtom.reportRead();
    return super.seconds;
  }

  @override
  set seconds(int? value) {
    _$secondsAtom.reportWrite(value, super.seconds, () {
      super.seconds = value;
    });
  }

  @override
  String toString() {
    return '''
minutes: ${minutes},
seconds: ${seconds}
    ''';
  }
}
