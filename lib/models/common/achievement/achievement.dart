import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'achievement.g.dart';

@JsonSerializable()
class Achievement extends Equatable {
  final int id;
  final String title;
  final String description;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);

  Map<String, dynamic> toJson() => _$AchievementToJson(this);

  @override
  List<Object?> get props => [id];
}

@JsonSerializable()
class AchievementList {
  List<Achievement> achievements;

  AchievementList({
    required this.achievements,
  });

  factory AchievementList.fromJson(Map<String, dynamic> json) =>
      _$AchievementListFromJson(json);

  Map<String, dynamic> toJson() => _$AchievementListToJson(this);
}
