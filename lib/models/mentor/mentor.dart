import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/models/common/category/category.dart';
import 'package:mobile/models/common/degree/degree.dart';
import 'package:mobile/models/common/experience/experience.dart';
import 'package:mobile/models/common/program/program.dart';
import 'package:mobile/models/common/skill/skill.dart';
import 'package:validators/validators.dart';

part 'mentor.g.dart';

//:-----------------------------------------------------------------------------

@JsonSerializable()
class MentorModelList {
  @JsonKey(name: "data")
  List<MentorModel> list;

  MentorModelList({
    required this.list,
  });

  factory MentorModelList.fromJson(Map<String, dynamic> json) =>
      _$MentorModelListFromJson(json);

  Map<String, dynamic> toJson() => _$MentorModelListToJson(this);
}

//:-----------------------------------------------------------------------------

@JsonSerializable()
class MentorModel {
  int id;
  String name;
  DateTime birthday;
  String? avatar;
  // bool? isPasswordSet;

  @JsonKey(name: "User_mentor")
  UserMentor userMentor;

  MentorModel({
    required this.id,
    required this.name,
    required this.birthday,
    required this.avatar,
    // required this.isPasswordSet,
    required this.userMentor,
  }) {
    if (!isURL(avatar) || avatar == "avatar.png") {
      avatar = null;
    }
  }

  factory MentorModel.fromJson(Map<String, dynamic> json) =>
      _$MentorModelFromJson(json);

  Map<String, dynamic> toJson() => _$MentorModelToJson(this);

  int get age => DateTime.now().year - birthday.year;
}

//:-----------------------------------------------------------------------------

@JsonSerializable()
class UserMentor {
  String? linkedin;
  String introduction;
  int rating;
  List<Program>? programs;
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
