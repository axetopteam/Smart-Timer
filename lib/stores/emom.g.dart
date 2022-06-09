// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Emom _$EmomFromJson(Map<String, dynamic> json) => Emom(
      roundsCount: json['roundsCount'] as int?,
      workTime: json['workTime'] == null
          ? null
          : Duration(microseconds: json['workTime'] as int),
      showSets: json['showSets'] as bool?,
      setsCount: json['setsCount'] as int?,
      restBetweenSets: json['restBetweenSets'] == null
          ? null
          : Duration(microseconds: json['restBetweenSets'] as int),
    );

Map<String, dynamic> _$EmomToJson(Emom instance) => <String, dynamic>{
      'roundsCount': instance.roundsCount,
      'workTime': instance.workTime.inMicroseconds,
      'showSets': instance.showSets,
      'setsCount': instance.setsCount,
      'restBetweenSets': instance.restBetweenSets.inMicroseconds,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Emom on EmomBase, Store {
  late final _$roundsCountAtom =
      Atom(name: 'EmomBase.roundsCount', context: context);

  @override
  int get roundsCount {
    _$roundsCountAtom.reportRead();
    return super.roundsCount;
  }

  @override
  set roundsCount(int value) {
    _$roundsCountAtom.reportWrite(value, super.roundsCount, () {
      super.roundsCount = value;
    });
  }

  late final _$workTimeAtom = Atom(name: 'EmomBase.workTime', context: context);

  @override
  Duration get workTime {
    _$workTimeAtom.reportRead();
    return super.workTime;
  }

  @override
  set workTime(Duration value) {
    _$workTimeAtom.reportWrite(value, super.workTime, () {
      super.workTime = value;
    });
  }

  late final _$showSetsAtom = Atom(name: 'EmomBase.showSets', context: context);

  @override
  bool get showSets {
    _$showSetsAtom.reportRead();
    return super.showSets;
  }

  @override
  set showSets(bool value) {
    _$showSetsAtom.reportWrite(value, super.showSets, () {
      super.showSets = value;
    });
  }

  late final _$setsCountAtom =
      Atom(name: 'EmomBase.setsCount', context: context);

  @override
  int get setsCount {
    _$setsCountAtom.reportRead();
    return super.setsCount;
  }

  @override
  set setsCount(int value) {
    _$setsCountAtom.reportWrite(value, super.setsCount, () {
      super.setsCount = value;
    });
  }

  late final _$restBetweenSetsAtom =
      Atom(name: 'EmomBase.restBetweenSets', context: context);

  @override
  Duration get restBetweenSets {
    _$restBetweenSetsAtom.reportRead();
    return super.restBetweenSets;
  }

  @override
  set restBetweenSets(Duration value) {
    _$restBetweenSetsAtom.reportWrite(value, super.restBetweenSets, () {
      super.restBetweenSets = value;
    });
  }

  late final _$EmomBaseActionController =
      ActionController(name: 'EmomBase', context: context);

  @override
  void setRounds(int value) {
    final _$actionInfo =
        _$EmomBaseActionController.startAction(name: 'EmomBase.setRounds');
    try {
      return super.setRounds(value);
    } finally {
      _$EmomBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWorkTime(Duration duration) {
    final _$actionInfo =
        _$EmomBaseActionController.startAction(name: 'EmomBase.setWorkTime');
    try {
      return super.setWorkTime(duration);
    } finally {
      _$EmomBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleShowSets() {
    final _$actionInfo =
        _$EmomBaseActionController.startAction(name: 'EmomBase.toggleShowSets');
    try {
      return super.toggleShowSets();
    } finally {
      _$EmomBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRestBetweenSets(Duration duration) {
    final _$actionInfo = _$EmomBaseActionController.startAction(
        name: 'EmomBase.setRestBetweenSets');
    try {
      return super.setRestBetweenSets(duration);
    } finally {
      _$EmomBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSetsCount(int value) {
    final _$actionInfo =
        _$EmomBaseActionController.startAction(name: 'EmomBase.setSetsCount');
    try {
      return super.setSetsCount(value);
    } finally {
      _$EmomBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
roundsCount: ${roundsCount},
workTime: ${workTime},
showSets: ${showSets},
setsCount: ${setsCount},
restBetweenSets: ${restBetweenSets}
    ''';
  }
}
