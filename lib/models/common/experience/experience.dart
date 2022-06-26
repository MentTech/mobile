import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

@JsonSerializable()
class Experience {
  int id;
  // int? mentorId;
  String? title;
  String? company;
  String? description;
  DateTime? startAt;
  DateTime? endAt;

  Experience({
    required this.id,
    // this.mentorId,
    this.title,
    this.company,
    this.description,
    this.startAt,
    this.endAt,
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}
