// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amrap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Amrap _$AmrapFromJson(Map<String, dynamic> json) => Amrap(
      workTime: Duration(microseconds: json['workTime'] as int),
      restTime: Duration(microseconds: json['restTime'] as int),
    );

Map<String, dynamic> _$AmrapToJson(Amrap instance) => <String, dynamic>{
      'workTime': instance.workTime.inMicroseconds,
      'restTime': instance.restTime.inMicroseconds,
    };
