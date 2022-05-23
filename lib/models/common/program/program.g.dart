// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Program _$ProgramFromJson(Map<String, dynamic> json) => Program(
      id: json['id'] as int,
      mentorId: json['mentorId'] as int,
      title: json['title'] as String,
      detail: json['detail'] as String,
      credit: json['credit'] as int,
      createAt: DateTime.parse(json['createAt'] as String),
      averageRating: json['averageRating'] == null
          ? null
          : AverageRating.fromJson(
              json['averageRating'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProgramToJson(Program instance) => <String, dynamic>{
      'id': instance.id,
      'mentorId': instance.mentorId,
      'title': instance.title,
      'detail': instance.detail,
      'credit': instance.credit,
      'createAt': instance.createAt.toIso8601String(),
      'averageRating': instance.averageRating,
    };

AverageRating _$AverageRatingFromJson(Map<String, dynamic> json) =>
    AverageRating(
      average: json['average'] as int,
      count: json['count'] as int,
    );

Map<String, dynamic> _$AverageRatingToJson(AverageRating instance) =>
    <String, dynamic>{
      'average': instance.average,
      'count': instance.count,
    };
