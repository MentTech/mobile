import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/models/common/category/category.dart';
import 'package:mobile/models/common/degree/degree.dart';
import 'package:mobile/models/common/experience/experience.dart';
import 'package:mobile/models/common/program/program.dart';
import 'package:mobile/models/common/skill/skill.dart';

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
class MentorModel extends Equatable {
  final int id;
  final String name;
  final DateTime? birthday;
  final String? avatar;
  // bool? isPasswordSet;

  @JsonKey(name: "User_mentor")
  final UserMentor userMentor;

  const MentorModel({
    required this.id,
    required this.name,
    this.birthday,
    this.avatar,
    // required this.isPasswordSet,
    required this.userMentor,
  });

  factory MentorModel.fromJson(Map<String, dynamic> json) =>
      _$MentorModelFromJson(json);

  Map<String, dynamic> toJson() => _$MentorModelToJson(this);

  int get age => DateTime.now().year - (birthday?.year ?? DateTime.now().year);

  @override
  List<Object?> get props => [id];
}

//:-----------------------------------------------------------------------------

@JsonSerializable()
class UserMentor {
  // String? linkedin;
  String? introduction;
  double? rating;
  List<Program>? programs;
  Category category;
  List<Skill> skills;
  List<Degree> degree;
  List<Experience> experiences;

  UserMentor({
    // required this.linkedin,
    required this.introduction,
    required this.rating,
    required this.programs,
    required this.category,
    this.skills = const <Skill>[],
    this.degree = const <Degree>[],
    this.experiences = const <Experience>[],
  });

  factory UserMentor.fromJson(Map<String, dynamic> json) =>
      _$UserMentorFromJson(json);

  Map<String, dynamic> toJson() => _$UserMentorToJson(this);
}
