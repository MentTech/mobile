// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Skill _$SkillFromJson(Map<String, dynamic> json) => Skill(
      id: json['id'] as int,
      description: json['description'] as String?,
      additional: json['additional'] as String?,
      isAccepted: json['isAccepted'] as bool,
    );

Map<String, dynamic> _$SkillToJson(Skill instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'additional': instance.additional,
      'isAccepted': instance.isAccepted,
    };
