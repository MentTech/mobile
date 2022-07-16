// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionTypeModel _$SessionTypeModelFromJson(Map<String, dynamic> json) =>
    SessionTypeModel(
      id: json['id'] as int,
      sessionType: $enumDecode(_$SessionTypeEnumMap, json['name']),
      createAt: DateTime.parse(json['createAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$SessionTypeModelToJson(SessionTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': _$SessionTypeEnumMap[instance.sessionType]!,
      'createAt': instance.createAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$SessionTypeEnumMap = {
  SessionType.MENTEE_SESSION_ACCEPTED: 'MENTEE_SESSION_ACCEPTED',
};
