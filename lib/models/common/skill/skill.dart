import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'skill.g.dart';

@JsonSerializable()
class Skill extends Equatable {
  final int id;
  final String? description;
  // String? additional;
  final bool isAccepted;

  @JsonKey(ignore: true)
  final double abilityPercent;

  Skill({
    required this.id,
    this.description,
    // this.additional,
    required this.isAccepted,
    this.abilityPercent = 0.5,
  }) {
    // abilityPercent = Random().nextDouble();
  }

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);

  Map<String, dynamic> toJson() => _$SkillToJson(this);

  @override
  List<Object?> get props => [id];
}

@JsonSerializable()
class SkillList extends Equatable {
  final List<Skill> skills;

  const SkillList({
    required this.skills,
  });

  factory SkillList.fromJson(Map<String, dynamic> json) =>
      _$SkillListFromJson(json);

  Map<String, dynamic> toJson() => _$SkillListToJson(this);

  @override
  List<Object?> get props => [skills];
}
