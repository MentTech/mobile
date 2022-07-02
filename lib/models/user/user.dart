import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  // @JsonKey(ignore: true)
  // bool isFaved;

  final int id;
  final String email;
  final String name;
  final DateTime? birthday;
  final String? phone;
  final String? avatar;
  final bool isActive;
  final int coin;
  final bool isPasswordSet;
  final DateTime createAt;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.birthday,
    this.phone,
    this.avatar,
    required this.isActive,
    required this.coin,
    required this.isPasswordSet,
    required this.createAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
