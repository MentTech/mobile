// ignore_for_file: prefer_final_fields

import 'package:mobile/models/common/additional/additional.dart';
import 'package:mobile/models/common/session_type/session_type_model.dart';
import 'package:mobile/models/notification/notification.dart';
import 'package:mobx/mobx.dart';

part 'model_notification.g.dart';

class NotificationModelStore = _NotificationModelStore
    with _$NotificationModelStore;

abstract class _NotificationModelStore with Store {
  _NotificationModelStore(NotificationModel notificationModel)
      : _id = notificationModel.id,
        _typeId = notificationModel.typeId,
        _actorId = notificationModel.actorId,
        _notifierId = notificationModel.notifierId,
        _message = notificationModel.message,
        _isRead = notificationModel.isRead,
        _additional = notificationModel.additional,
        _createAt = notificationModel.createAt,
        _updatedAt = notificationModel.updatedAt,
        _type = notificationModel.type;

  // observable variables:------------------------------------------------------

  @observable
  int _id;

  @observable
  int _typeId;

  @observable
  int _actorId;

  @observable
  int _notifierId;

  @observable
  String _message;

  @observable
  bool _isRead;

  @observable
  Additional _additional;

  @observable
  DateTime _createAt;

  @observable
  DateTime _updatedAt;

  @observable
  SessionTypeModel _type;

  // computed:------------------------------------------------------------------

  @computed
  int get id => _id;

  @computed
  int get typeId => _typeId;

  @computed
  int get actorId => _actorId;

  @computed
  int get notifierId => _notifierId;

  @computed
  String get message => _message;

  @computed
  bool get isRead => _isRead;

  @computed
  Additional get additional => _additional;

  @computed
  DateTime get createAt => _createAt;

  @computed
  DateTime get updatedAt => _createAt;

  @computed
  SessionTypeModel get type => _type;

  // actions:-------------------------------------------------------------------
  @action
  void read() {
    _isRead = true;
  }

  // general methods:-----------------------------------------------------------

}
