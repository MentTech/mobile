import 'package:json_annotation/json_annotation.dart';

part 'rate.g.dart';

@JsonSerializable()
class RateModel {
  final int id;
  final int registerId;
  final double rating;
  final String comment;
  final DateTime createAt;
  final SubFastAccessUser user;

  RateModel({
    required this.id,
    required this.registerId,
    required this.rating,
    required this.comment,
    required this.createAt,
    required this.user,
  });

  factory RateModel.fromJson(Map<String, dynamic> json) =>
      _$RateModelFromJson(json);

  Map<String, dynamic> toJson() => _$RateModelToJson(this);
}

@JsonSerializable()
class SubFastAccessUser {
  String name;
  String avatar;

  SubFastAccessUser({
    required this.name,
    required this.avatar,
  });

  factory SubFastAccessUser.fromJson(Map<String, dynamic> json) =>
      _$SubFastAccessUserFromJson(json);

  Map<String, dynamic> toJson() => _$SubFastAccessUserToJson(this);
}

@JsonSerializable()
class RateModelList {
  @JsonKey(name: "data")
  final List<RateModel> rateModels;

  RateModelList({
    required this.rateModels,
  });

  factory RateModelList.fromJson(Map<String, dynamic> json) =>
      _$RateModelListFromJson(json);

  Map<String, dynamic> toJson() => _$RateModelListToJson(this);
}
