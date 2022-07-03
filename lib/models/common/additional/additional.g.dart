// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Additional _$AdditionalFromJson(Map<String, dynamic> json) => Additional(
      program: ShortProgram.fromJson(json['program'] as Map<String, dynamic>),
      sessionId: json['sessionId'] as int,
    );

Map<String, dynamic> _$AdditionalToJson(Additional instance) =>
    <String, dynamic>{
      'program': instance.program,
      'sessionId': instance.sessionId,
    };

ShortProgram _$ShortProgramFromJson(Map<String, dynamic> json) => ShortProgram(
      id: json['id'] as int,
      title: json['title'] as String,
    );

Map<String, dynamic> _$ShortProgramToJson(ShortProgram instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
