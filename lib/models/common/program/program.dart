import 'package:json_annotation/json_annotation.dart';

part 'program.g.dart';

@JsonSerializable()
class Program {
  int id;
  // int mentorId;
  String title;
  String detail;
  int credit;
  String createAt;

  Program({
    required this.id,
    // required this.mentorId,
    required this.title,
    required this.detail,
    required this.credit,
    required this.createAt,
  });

  factory Program.fromJson(Map<String, dynamic> json) =>
      _$ProgramFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramToJson(this);
}
