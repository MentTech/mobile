// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as int,
      typeId: json['typeId'] as int,
      actorId: json['actorId'] as int,
      notifierId: json['notifierId'] as int,
      message: json['message'] as String,
      isRead: json['isRead'] as bool,
      additional:
          Additional.fromJson(json['additional'] as Map<String, dynamic>),
      createAt: DateTime.parse(json['createAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      type: SessionTypeModel.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typeId': instance.typeId,
      'actorId': instance.actorId,
      'notifierId': instance.notifierId,
      'message': instance.message,
      'isRead': instance.isRead,
      'additional': instance.additional,
      'createAt': instance.createAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'type': instance.type,
    };

NotificationList _$NotificationListFromJson(Map<String, dynamic> json) =>
    NotificationList(
      notifications: (json['data'] as List<dynamic>)
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationListToJson(NotificationList instance) =>
    <String, dynamic>{
      'data': instance.notifications,
    };
