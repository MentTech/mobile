import 'package:json_annotation/json_annotation.dart';

part 'degree.g.dart';

@JsonSerializable()
class Degree {
  int id;
  // int mentorId;
  String title;
  String issuer;
  String? description;
  String? degreeId;
  String? url;

  Degree({
    required this.id,
    // required this.mentorId,
    required this.title,
    required this.issuer,
    this.description,
    this.degreeId,
    this.url,
  });

  factory Degree.fromJson(Map<String, dynamic> json) => _$DegreeFromJson(json);

  Map<String, dynamic> toJson() => _$DegreeToJson(this);
}
