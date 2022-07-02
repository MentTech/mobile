// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as int,
      orderId: json['orderId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      userId: json['userId'] as int,
      orderType: json['orderType'] as String,
      paymentMethod: json['paymentMethod'] as String,
      status: json['status'] as String,
      token: json['token'] as int,
      total: json['total'] as int,
      createAt: json['createAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'name': instance.name,
      'email': instance.email,
      'userId': instance.userId,
      'orderType': instance.orderType,
      'paymentMethod': instance.paymentMethod,
      'status': instance.status,
      'token': instance.token,
      'total': instance.total,
      'createAt': instance.createAt,
      'updatedAt': instance.updatedAt,
    };
