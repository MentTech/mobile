// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int,
      email: json['email'] as String,
      name: json['name'] as String,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
      isActive: json['isActive'] as bool,
      coin: json['coin'] as int,
      isPasswordSet: json['isPasswordSet'] as bool,
      createAt: DateTime.parse(json['createAt'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'birthday': instance.birthday?.toIso8601String(),
      'phone': instance.phone,
      'avatar': instance.avatar,
      'isActive': instance.isActive,
      'coin': instance.coin,
      'isPasswordSet': instance.isPasswordSet,
      'createAt': instance.createAt.toIso8601String(),
    };
