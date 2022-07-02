import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  final int id;
  final String orderId;
  final String name;
  final String email;
  final int userId;
  final String orderType;
  final String paymentMethod;
  final String status;
  final int token;
  final int total;
  final String createAt;
  final String updatedAt;

  Order({
    required this.id,
    required this.orderId,
    required this.name,
    required this.email,
    required this.userId,
    required this.orderType,
    required this.paymentMethod,
    required this.status,
    required this.token,
    required this.total,
    required this.createAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
