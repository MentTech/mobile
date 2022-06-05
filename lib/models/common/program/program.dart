import 'package:json_annotation/json_annotation.dart';

part 'program.g.dart';

@JsonSerializable()
class Program {
  int id;
  int mentorId;
  String title;
  String detail;
  int credit;
  DateTime? createAt;
  AverageRating? averageRating;

  Program({
    required this.id,
    required this.mentorId,
    required this.title,
    required this.detail,
    required this.credit,
    this.createAt,
    this.averageRating,
  });

  factory Program.fromJson(Map<String, dynamic> json) =>
      _$ProgramFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramToJson(this);
}

@JsonSerializable()
class AverageRating {
  double average;
  int count;

  AverageRating({
    required this.average,
    required this.count,
  });

  factory AverageRating.fromJson(Map<String, dynamic> json) =>
      _$AverageRatingFromJson(json);

  Map<String, dynamic> toJson() => _$AverageRatingToJson(this);
}
