// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_picker_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TimerPickerState on TimerPickerStateBase, Store {
  Computed<int?>? _$minutesComputed;

  @override
  int? get minutes => (_$minutesComputed ??= Computed<int?>(() => super.minutes,
          name: 'TimerPickerStateBase.minutes'))
      .value;
  Computed<int?>? _$secondsComputed;

  @override
  int? get seconds => (_$secondsComputed ??= Computed<int?>(() => super.seconds,
          name: 'TimerPickerStateBase.seconds'))
      .value;

  late final _$minutesIndexAtom =
      Atom(name: 'TimerPickerStateBase.minutesIndex', context: context);

  @override
  int? get minutesIndex {
    _$minutesIndexAtom.reportRead();
    return super.minutesIndex;
  }

  @override
  set minutesIndex(int? value) {
    _$minutesIndexAtom.reportWrite(value, super.minutesIndex, () {
      super.minutesIndex = value;
    });
  }

  late final _$secondsIndexAtom =
      Atom(name: 'TimerPickerStateBase.secondsIndex', context: context);

  @override
  int? get secondsIndex {
    _$secondsIndexAtom.reportRead();
    return super.secondsIndex;
  }

  @override
  set secondsIndex(int? value) {
    _$secondsIndexAtom.reportWrite(value, super.secondsIndex, () {
      super.secondsIndex = value;
    });
  }

  late final _$noTimeCapAtom =
      Atom(name: 'TimerPickerStateBase.noTimeCap', context: context);

  @override
  bool get noTimeCap {
    _$noTimeCapAtom.reportRead();
    return super.noTimeCap;
  }

  @override
  set noTimeCap(bool value) {
    _$noTimeCapAtom.reportWrite(value, super.noTimeCap, () {
      super.noTimeCap = value;
    });
  }

  @override
  String toString() {
    return '''
minutesIndex: ${minutesIndex},
secondsIndex: ${secondsIndex},
noTimeCap: ${noTimeCap},
minutes: ${minutes},
seconds: ${seconds}
    ''';
  }
}
