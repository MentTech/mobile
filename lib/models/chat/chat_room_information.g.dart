// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomInformation _$ChatRoomInformationFromJson(Map<String, dynamic> json) =>
    ChatRoomInformation(
      id: json['id'] as int,
      name: json['name'] as String,
      sessionId: json['sessionId'] as int,
      isActive: json['isActive'] as bool,
      createAt: DateTime.parse(json['createAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ChatRoomInformationToJson(
        ChatRoomInformation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sessionId': instance.sessionId,
      'isActive': instance.isActive,
      'createAt': instance.createAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
