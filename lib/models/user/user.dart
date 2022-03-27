import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  // @JsonKey(ignore: true)
  // bool isFaved;

  int id;
  String email;
  String name;
  DateTime? birthday;
  String? phone;
  String? avatar;
  bool isActive;
  int coin;
  bool isPasswordSet;
  DateTime createAt;

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
