import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/models/common/program/program.dart';

part 'session.g.dart';

@JsonSerializable()
class Session {
  int id;
  bool isAccepted;
  bool done;
  bool isCanceled;
  DateTime? expectedDate;
  Program program;

  Session({
    required this.id,
    required this.isAccepted,
    required this.isCanceled,
    required this.done,
    required this.program,
    this.expectedDate,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
