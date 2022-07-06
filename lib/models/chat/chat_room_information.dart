import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_room_information.g.dart';

@JsonSerializable()
class ChatRoomInformation extends Equatable {
  final int id;
  final String name;
  final int sessionId;
  final bool isActive;
  final String createAt;
  final String updatedAt;

  const ChatRoomInformation({
    required this.id,
    required this.name,
    required this.sessionId,
    required this.isActive,
    required this.createAt,
    required this.updatedAt,
  });

  factory ChatRoomInformation.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomInformationFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomInformationToJson(this);

  @override
  List<Object?> get props => [id];
}
