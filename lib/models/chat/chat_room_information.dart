import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/models/chat/room_information.dart';

part 'chat_room_information.g.dart';

@JsonSerializable()
class ChatRoomInformation extends Equatable {
  final int id;
  final String name;
  // final int sessionId;
  final bool isActive;
  // final DateTime createAt;
  // final DateTime updatedAt;
  final List<Participant> participants;

  const ChatRoomInformation({
    required this.id,
    required this.name,
    // required this.sessionId,
    required this.isActive,
    // required this.createAt,
    // required this.updatedAt,
    this.participants = const [],
  });

  factory ChatRoomInformation.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomInformationFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomInformationToJson(this);

  @override
  List<Object?> get props => [id];
}
