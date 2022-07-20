// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomInformation _$ChatRoomInformationFromJson(Map<String, dynamic> json) =>
    ChatRoomInformation(
      id: json['id'] as int,
      name: json['name'] as String,
      isActive: json['isActive'] as bool,
      participants: (json['participants'] as List<dynamic>?)
              ?.map((e) => Participant.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ChatRoomInformationToJson(
        ChatRoomInformation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isActive': instance.isActive,
      'participants': instance.participants,
    };
