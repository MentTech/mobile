import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

part 'skill.g.dart';

@JsonSerializable()
class Skill {
  int id;
  String? description;
  // String? additional;
  bool isAccepted;

  @JsonKey(ignore: true)
  double abilityPercent;

  Skill({
    required this.id,
    this.description,
    // this.additional,
    required this.isAccepted,
    this.abilityPercent = 0.5,
  }) {
    abilityPercent = Random().nextDouble();
  }

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);

  Map<String, dynamic> toJson() => _$SkillToJson(this);
}