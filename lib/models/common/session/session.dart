import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/models/common/additional/additional.dart';
import 'package:mobile/models/common/program/program.dart';
import 'package:mobile/models/rate/rate.dart';

part 'session.g.dart';

@JsonSerializable()
class Session extends Equatable {
  final int id;
  final bool isAccepted;
  final bool done;
  final bool isCanceled;
  final DateTime? expectedDate;
  final Program program;
  final String? contactInfo;
  final RateModel? rating;
  final Additional? additional;

  const Session({
    required this.id,
    required this.isAccepted,
    required this.isCanceled,
    required this.done,
    required this.program,
    this.expectedDate,
    this.contactInfo,
    this.additional,
    this.rating,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);

  @override
  List<Object?> get props => [id];
}
