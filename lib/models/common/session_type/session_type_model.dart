import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/stores/enum/session_type.dart';

part 'session_type_model.g.dart';

@JsonSerializable()
class SessionTypeModel extends Equatable {
  final int id;

  @JsonKey(name: "name")
  final SessionType sessionType;

  final DateTime createAt;
  final DateTime updatedAt;

  const SessionTypeModel({
    required this.id,
    required this.sessionType,
    required this.createAt,
    required this.updatedAt,
  });

  factory SessionTypeModel.fromJson(Map<String, dynamic> json) =>
      _$SessionTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$SessionTypeModelToJson(this);

  @override
  List<Object?> get props => [id, sessionType];
}
