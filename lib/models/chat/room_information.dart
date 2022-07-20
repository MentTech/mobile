import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room_information.g.dart';

@JsonSerializable()
class RoomInformation extends Equatable {
  final int id;
  final String name;
  final int sessionId;
  final bool isActive;
  final DateTime createAt;
  final DateTime updatedAt;
  final List<Participant> participants;

  const RoomInformation({
    required this.id,
    required this.name,
    required this.sessionId,
    required this.isActive,
    required this.createAt,
    required this.updatedAt,
    required this.participants,
  });

  factory RoomInformation.fromJson(Map<String, dynamic> json) =>
      _$RoomInformationFromJson(json);

  Map<String, dynamic> toJson() => _$RoomInformationToJson(this);

  @override
  List<Object?> get props => [id];
}

@JsonSerializable()
class Participant extends Equatable {
  final int id;
  final String name;
  final String avatar;

  const Participant({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantToJson(this);

  @override
  List<Object?> get props => [id];
}
