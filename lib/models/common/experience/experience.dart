import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

@JsonSerializable()
class Experience {
  int id;
  // int? mentorId;
  String? title;
  String? company;
  String? description;

  Experience({
    required this.id,
    // this.mentorId,
    this.title,
    this.company,
    this.description,
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}
