// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateModel _$RateModelFromJson(Map<String, dynamic> json) => RateModel(
      id: json['id'] as int,
      registerId: json['registerId'] as int,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      createAt: DateTime.parse(json['createAt'] as String),
      user: json['user'] == null
          ? null
          : SubFastAccessUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RateModelToJson(RateModel instance) => <String, dynamic>{
      'id': instance.id,
      'registerId': instance.registerId,
      'rating': instance.rating,
      'comment': instance.comment,
      'createAt': instance.createAt.toIso8601String(),
      'user': instance.user,
    };

SubFastAccessUser _$SubFastAccessUserFromJson(Map<String, dynamic> json) =>
    SubFastAccessUser(
      name: json['name'] as String,
      avatar: json['avatar'] as String,
    );

Map<String, dynamic> _$SubFastAccessUserToJson(SubFastAccessUser instance) =>
    <String, dynamic>{
      'name': instance.name,
      'avatar': instance.avatar,
    };

RateModelList _$RateModelListFromJson(Map<String, dynamic> json) =>
    RateModelList(
      rateModels: (json['data'] as List<dynamic>)
          .map((e) => RateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RateModelListToJson(RateModelList instance) =>
    <String, dynamic>{
      'data': instance.rateModels,
    };
