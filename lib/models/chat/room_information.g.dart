// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomInformation _$RoomInformationFromJson(Map<String, dynamic> json) =>
    RoomInformation(
      id: json['id'] as int,
      name: json['name'] as String,
      sessionId: json['sessionId'] as int,
      isActive: json['isActive'] as bool,
      createAt: DateTime.parse(json['createAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => Participant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoomInformationToJson(RoomInformation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sessionId': instance.sessionId,
      'isActive': instance.isActive,
      'createAt': instance.createAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'participants': instance.participants,
    };

Participant _$ParticipantFromJson(Map<String, dynamic> json) => Participant(
      id: json['id'] as int,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
    );

Map<String, dynamic> _$ParticipantToJson(Participant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
    };
