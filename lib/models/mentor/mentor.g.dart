// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MentorModelList _$MentorModelListFromJson(Map<String, dynamic> json) =>
    MentorModelList(
      list: (json['data'] as List<dynamic>)
          .map((e) => MentorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MentorModelListToJson(MentorModelList instance) =>
    <String, dynamic>{
      'data': instance.list,
    };

MentorModel _$MentorModelFromJson(Map<String, dynamic> json) => MentorModel(
      id: json['id'] as int,
      name: json['name'] as String,
      birthday: DateTime.parse(json['birthday'] as String),
      avatar: json['avatar'] as String?,
      userMentor:
          UserMentor.fromJson(json['User_mentor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MentorModelToJson(MentorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'birthday': instance.birthday.toIso8601String(),
      'avatar': instance.avatar,
      'User_mentor': instance.userMentor,
    };

UserMentor _$UserMentorFromJson(Map<String, dynamic> json) => UserMentor(
      linkedin: json['linkedin'] as String?,
      introduction: json['introduction'] as String,
      rating: json['rating'] as int,
      programs: (json['programs'] as List<dynamic>)
          .map((e) => Program.fromJson(e as Map<String, dynamic>))
          .toList(),
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      skills: (json['skills'] as List<dynamic>)
          .map((e) => Skill.fromJson(e as Map<String, dynamic>))
          .toList(),
      degree: (json['degree'] as List<dynamic>)
          .map((e) => Degree.fromJson(e as Map<String, dynamic>))
          .toList(),
      experiences: (json['experiences'] as List<dynamic>)
          .map((e) => Experience.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserMentorToJson(UserMentor instance) =>
    <String, dynamic>{
      'linkedin': instance.linkedin,
      'introduction': instance.introduction,
      'rating': instance.rating,
      'programs': instance.programs,
      'category': instance.category,
      'skills': instance.skills,
      'degree': instance.degree,
      'experiences': instance.experiences,
    };
