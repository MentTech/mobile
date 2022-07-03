import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/models/common/additional/additional.dart';
import 'package:mobile/models/common/session_type/session_type_model.dart';

part 'notification.g.dart';

@JsonSerializable()
class NotificationModel extends Equatable {
  final int id;
  final int typeId;
  final int actorId;
  final int notifierId;
  final String message;
  final bool isRead;
  final Additional additional;
  final DateTime createAt;
  final DateTime updatedAt;
  final SessionTypeModel type;

  const NotificationModel({
    required this.id,
    required this.typeId,
    required this.actorId,
    required this.notifierId,
    required this.message,
    required this.isRead,
    required this.additional,
    required this.createAt,
    required this.updatedAt,
    required this.type,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @override
  List<Object?> get props => [id, isRead];

  NotificationModel toReadedModel() {
    if (isRead) {
      return this;
    }

    return NotificationModel(
      id: id,
      typeId: typeId,
      actorId: actorId,
      notifierId: notifierId,
      message: message,
      isRead: true,
      additional: additional,
      createAt: createAt,
      updatedAt: updatedAt,
      type: type,
    );
  }
}

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

@JsonSerializable()
class NotificationList {
  @JsonKey(name: "data")
  final List<NotificationModel> notifications;

  NotificationList({
    required this.notifications,
  });

  factory NotificationList.fromJson(Map<String, dynamic> json) =>
      _$NotificationListFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationListToJson(this);
}

//------------------------------------------------------------------------------
