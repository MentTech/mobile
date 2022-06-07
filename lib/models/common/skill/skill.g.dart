// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Skill _$SkillFromJson(Map<String, dynamic> json) => Skill(
      id: json['id'] as int,
      description: json['description'] as String?,
      isAccepted: json['isAccepted'] as bool,
    );

Map<String, dynamic> _$SkillToJson(Skill instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'isAccepted': instance.isAccepted,
    };

SkillList _$SkillListFromJson(Map<String, dynamic> json) => SkillList(
      skills: (json['skills'] as List<dynamic>)
          .map((e) => Skill.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SkillListToJson(SkillList instance) => <String, dynamic>{
      'skills': instance.skills,
    };
