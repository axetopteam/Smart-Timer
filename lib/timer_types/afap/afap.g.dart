// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'afap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Afap _$AfapFromJson(Map<String, dynamic> json) => Afap(
      timeCap: Duration(microseconds: json['timeCap'] as int),
      restTime: Duration(microseconds: json['restTime'] as int),
      noTimeCap: json['noTimeCap'] as bool,
    );

Map<String, dynamic> _$AfapToJson(Afap instance) => <String, dynamic>{
      'timeCap': instance.timeCap.inMicroseconds,
      'restTime': instance.restTime.inMicroseconds,
      'noTimeCap': instance.noTimeCap,
    };
