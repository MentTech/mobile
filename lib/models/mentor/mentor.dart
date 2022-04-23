import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/models/categories/category/category.dart';
import 'package:mobile/models/categories/degree/degree.dart';
import 'package:mobile/models/categories/experience/experience.dart';
import 'package:mobile/models/categories/program/program.dart';
import 'package:mobile/models/categories/skill/skill.dart';

part 'mentor.g.dart';

@JsonSerializable()
class MentorModel {
  int id;
  String name;
  String birthday;
  String avatar;
  // bool? isPasswordSet;
  UserMentor userMentor;

  MentorModel({
    required this.id,
    required this.name,
    required this.birthday,
    required this.avatar,
    // required this.isPasswordSet,
    required this.userMentor,
  });

  factory MentorModel.fromJson(Map<String, dynamic> json) =>
      _$MentorModelFromJson(json);

  Map<String, dynamic> toJson() => _$MentorModelToJson(this);
}

//:-----------------------------------------------------------------------------

@JsonSerializable()
class UserMentor {
  String linkedin;
  String introduction;
  int rating;
  List<Program> programs;
  Category category;
  List<Skill> skills;
  List<Degree> degree;
  List<Experience> experiences;

  UserMentor({
    required this.linkedin,
    required this.introduction,
    required this.rating,
    required this.programs,
    required this.category,
    required this.skills,
    required this.degree,
    required this.experiences,
  });

  factory UserMentor.fromJson(Map<String, dynamic> json) =>
      _$UserMentorFromJson(json);

  Map<String, dynamic> toJson() => _$UserMentorToJson(this);
}
