import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'additional.g.dart';

@JsonSerializable()
class Additional extends Equatable {
  final ShortProgram program;
  final int sessionId;

  const Additional({
    required this.program,
    required this.sessionId,
  });

  factory Additional.fromJson(Map<String, dynamic> json) =>
      _$AdditionalFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalToJson(this);

  @override
  List<Object?> get props => [sessionId, program];
}

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

@JsonSerializable()
class ShortProgram extends Equatable {
  final int id;
  final String title;

  const ShortProgram({
    required this.id,
    required this.title,
  });

  factory ShortProgram.fromJson(Map<String, dynamic> json) =>
      _$ShortProgramFromJson(json);

  Map<String, dynamic> toJson() => _$ShortProgramToJson(this);

  @override
  List<Object?> get props => [id, title];
}

//------------------------------------------------------------------------------