import 'package:json_annotation/json_annotation.dart';

part 'skill.g.dart';

@JsonSerializable()
class Skill {
  int id;
  String? description;
  String? additional;
  bool isAccepted;

  Skill({
    required this.id,
    this.description,
    this.additional,
    required this.isAccepted,
  });

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);

  Map<String, dynamic> toJson() => _$SkillToJson(this);
}
