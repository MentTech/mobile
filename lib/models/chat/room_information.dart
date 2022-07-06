import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room_information.g.dart';

@JsonSerializable()
class RoomInformation extends Equatable {
  final int id;
  final String name;
  final int sessionId;
  final bool isActive;
  final String createAt;
  final String updatedAt;
  final List<Participants> participants;

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
class Participants extends Equatable {
  final int id;
  final String name;
  final String avatar;

  const Participants({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory Participants.fromJson(Map<String, dynamic> json) =>
      _$ParticipantsFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantsToJson(this);

  @override
  List<Object?> get props => [id];
}
