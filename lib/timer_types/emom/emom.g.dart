// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Emom _$EmomFromJson(Map<String, dynamic> json) => Emom(
      workTime: Duration(microseconds: json['workTime'] as int),
      roundsCount: json['roundsCount'] as int,
      restAfterSet: Duration(microseconds: json['restAfterSet'] as int),
    );

Map<String, dynamic> _$EmomToJson(Emom instance) => <String, dynamic>{
      'workTime': instance.workTime.inMicroseconds,
      'roundsCount': instance.roundsCount,
      'restAfterSet': instance.restAfterSet.inMicroseconds,
    };
