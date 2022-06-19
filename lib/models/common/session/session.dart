import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/models/common/program/program.dart';

part 'session.g.dart';

@JsonSerializable()
class Session extends Equatable {
  final int id;
  final bool isAccepted;
  final bool done;
  final bool isCanceled;
  final DateTime? expectedDate;
  final Program program;

  const Session({
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

  @override
  List<Object?> get props => [id];
}
