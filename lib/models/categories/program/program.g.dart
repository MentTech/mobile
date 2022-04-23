// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Program _$ProgramFromJson(Map<String, dynamic> json) => Program(
      id: json['id'] as int,
      title: json['title'] as String,
      detail: json['detail'] as String,
      credit: json['credit'] as int,
      createAt: json['createAt'] as String,
    );

Map<String, dynamic> _$ProgramToJson(Program instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'detail': instance.detail,
      'credit': instance.credit,
      'createAt': instance.createAt,
    };
