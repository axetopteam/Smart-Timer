// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tabata _$TabataFromJson(Map<String, dynamic> json) => Tabata(
      workTime: Duration(microseconds: json['workTime'] as int),
      restTime: Duration(microseconds: json['restTime'] as int),
      roundsCount: json['roundsCount'] as int,
      restAfterSet: Duration(microseconds: json['restAfterSet'] as int),
    );

Map<String, dynamic> _$TabataToJson(Tabata instance) => <String, dynamic>{
      'workTime': instance.workTime.inMicroseconds,
      'restTime': instance.restTime.inMicroseconds,
      'roundsCount': instance.roundsCount,
      'restAfterSet': instance.restAfterSet.inMicroseconds,
    };
