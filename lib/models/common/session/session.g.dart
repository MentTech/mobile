// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      id: json['id'] as int,
      isAccepted: json['isAccepted'] as bool,
      isCanceled: json['isCanceled'] as bool,
      done: json['done'] as bool,
      program: Program.fromJson(json['program'] as Map<String, dynamic>),
      expectedDate: json['expectedDate'] == null
          ? null
          : DateTime.parse(json['expectedDate'] as String),
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'isAccepted': instance.isAccepted,
      'done': instance.done,
      'isCanceled': instance.isCanceled,
      'expectedDate': instance.expectedDate?.toIso8601String(),
      'program': instance.program,
    };