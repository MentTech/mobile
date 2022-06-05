// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sessions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sessions _$SessionsFromJson(Map<String, dynamic> json) => Sessions(
      sessions: (json['sessions'] as List<dynamic>)
          .map((e) => Session.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SessionsToJson(Sessions instance) => <String, dynamic>{
      'sessions': instance.sessions,
    };
