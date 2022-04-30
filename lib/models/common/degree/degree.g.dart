// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'degree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Degree _$DegreeFromJson(Map<String, dynamic> json) => Degree(
      id: json['id'] as int,
      title: json['title'] as String,
      issuer: json['issuer'] as String,
      description: json['description'] as String?,
      degreeId: json['degreeId'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$DegreeToJson(Degree instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'issuer': instance.issuer,
      'description': instance.description,
      'degreeId': instance.degreeId,
      'url': instance.url,
    };
