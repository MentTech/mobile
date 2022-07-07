import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_chat.g.dart';

@JsonSerializable()
class ChatMessage extends Equatable {
  final int id;
  final int roomId;
  final int userId;
  final String content;
  final DateTime createAt;

  const ChatMessage({
    required this.id,
    required this.roomId,
    required this.userId,
    required this.content,
    required this.createAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);

  @override
  List<Object?> get props => [id];
}

@JsonSerializable()
class ChatMessageList extends Equatable {
  @JsonKey(name: "data")
  final List<ChatMessage> chatMessages;

  const ChatMessageList({required this.chatMessages});

  factory ChatMessageList.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageListFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageListToJson(this);

  @override
  List<Object?> get props => [chatMessages.length];
}
