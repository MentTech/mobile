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
      createAt: json['createAt'] as String,
      updatedAt: json['updatedAt'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => Participants.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoomInformationToJson(RoomInformation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sessionId': instance.sessionId,
      'isActive': instance.isActive,
      'createAt': instance.createAt,
      'updatedAt': instance.updatedAt,
      'participants': instance.participants,
    };

Participants _$ParticipantsFromJson(Map<String, dynamic> json) => Participants(
      id: json['id'] as int,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
    );

Map<String, dynamic> _$ParticipantsToJson(Participants instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
    };
