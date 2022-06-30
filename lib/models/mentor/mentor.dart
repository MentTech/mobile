import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/models/common/achievement/achievement.dart';
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
  final String? introduction;
  late final double? rating;
  final List<Program>? programs;
  final Category category;
  final List<Skill> skills;

  @JsonKey(name: "degree")
  final List<Degree> degrees;
  final List<Experience> experiences;
  final List<Achievement> achievements;

  UserMentor({
    // required this.linkedin,
    required this.introduction,
    double? rating,
    required this.programs,
    required this.category,
    this.skills = const <Skill>[],
    this.degrees = const <Degree>[],
    this.experiences = const <Experience>[],
    this.achievements = const <Achievement>[],
  }) {
    if (null != rating) {
      this.rating = double.parse(NumberFormat(".##").format(rating));
    }
  }

  factory UserMentor.fromJson(Map<String, dynamic> json) =>
      _$UserMentorFromJson(json);

  Map<String, dynamic> toJson() => _$UserMentorToJson(this);
}
