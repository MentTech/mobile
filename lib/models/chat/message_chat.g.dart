// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      id: json['id'] as int,
      roomId: json['roomId'] as int,
      userId: json['userId'] as int,
      content: json['content'] as String,
      createAt: DateTime.parse(json['createAt'] as String),
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomId': instance.roomId,
      'userId': instance.userId,
      'content': instance.content,
      'createAt': instance.createAt.toIso8601String(),
    };

ChatMessageList _$ChatMessageListFromJson(Map<String, dynamic> json) =>
    ChatMessageList(
      chatMessages: (json['data'] as List<dynamic>)
          .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatMessageListToJson(ChatMessageList instance) =>
    <String, dynamic>{
      'data': instance.chatMessages,
    };
