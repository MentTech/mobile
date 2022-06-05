import 'package:json_annotation/json_annotation.dart';

import 'session.dart';

part 'sessions.g.dart';

@JsonSerializable()
class Sessions {
  final List<Session> sessions;

  Sessions({
    required this.sessions,
  });

  factory Sessions.fromJson(Map<String, dynamic> json) =>
      _$SessionsFromJson(json);

  Map<String, dynamic> toJson() => _$SessionsToJson(this);
}
