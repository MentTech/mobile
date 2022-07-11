// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_notification.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotificationModelStore on _NotificationModelStore, Store {
  Computed<int>? _$idComputed;

  @override
  int get id => (_$idComputed ??=
          Computed<int>(() => super.id, name: '_NotificationModelStore.id'))
      .value;
  Computed<int>? _$typeIdComputed;

  @override
  int get typeId => (_$typeIdComputed ??= Computed<int>(() => super.typeId,
          name: '_NotificationModelStore.typeId'))
      .value;
  Computed<int>? _$actorIdComputed;

  @override
  int get actorId => (_$actorIdComputed ??= Computed<int>(() => super.actorId,
          name: '_NotificationModelStore.actorId'))
      .value;
  Computed<int>? _$notifierIdComputed;

  @override
  int get notifierId =>
      (_$notifierIdComputed ??= Computed<int>(() => super.notifierId,
              name: '_NotificationModelStore.notifierId'))
          .value;
  Computed<String>? _$messageComputed;

  @override
  String get message =>
      (_$messageComputed ??= Computed<String>(() => super.message,
              name: '_NotificationModelStore.message'))
          .value;
  Computed<bool>? _$isReadComputed;

  @override
  bool get isRead => (_$isReadComputed ??= Computed<bool>(() => super.isRead,
          name: '_NotificationModelStore.isRead'))
      .value;
  Computed<Additional>? _$additionalComputed;

  @override
  Additional get additional =>
      (_$additionalComputed ??= Computed<Additional>(() => super.additional,
              name: '_NotificationModelStore.additional'))
          .value;
  Computed<DateTime>? _$createAtComputed;

  @override
  DateTime get createAt =>
      (_$createAtComputed ??= Computed<DateTime>(() => super.createAt,
              name: '_NotificationModelStore.createAt'))
          .value;
  Computed<DateTime>? _$updatedAtComputed;

  @override
  DateTime get updatedAt =>
      (_$updatedAtComputed ??= Computed<DateTime>(() => super.updatedAt,
              name: '_NotificationModelStore.updatedAt'))
          .value;
  Computed<SessionTypeModel>? _$typeComputed;

  @override
  SessionTypeModel get type =>
      (_$typeComputed ??= Computed<SessionTypeModel>(() => super.type,
              name: '_NotificationModelStore.type'))
          .value;

  late final _$_idAtom =
      Atom(name: '_NotificationModelStore._id', context: context);

  @override
  int get _id {
    _$_idAtom.reportRead();
    return super._id;
  }

  @override
  set _id(int value) {
    _$_idAtom.reportWrite(value, super._id, () {
      super._id = value;
    });
  }

  late final _$_typeIdAtom =
      Atom(name: '_NotificationModelStore._typeId', context: context);

  @override
  int get _typeId {
    _$_typeIdAtom.reportRead();
    return super._typeId;
  }

  @override
  set _typeId(int value) {
    _$_typeIdAtom.reportWrite(value, super._typeId, () {
      super._typeId = value;
    });
  }

  late final _$_actorIdAtom =
      Atom(name: '_NotificationModelStore._actorId', context: context);

  @override
  int get _actorId {
    _$_actorIdAtom.reportRead();
    return super._actorId;
  }

  @override
  set _actorId(int value) {
    _$_actorIdAtom.reportWrite(value, super._actorId, () {
      super._actorId = value;
    });
  }

  late final _$_notifierIdAtom =
      Atom(name: '_NotificationModelStore._notifierId', context: context);

  @override
  int get _notifierId {
    _$_notifierIdAtom.reportRead();
    return super._notifierId;
  }

  @override
  set _notifierId(int value) {
    _$_notifierIdAtom.reportWrite(value, super._notifierId, () {
      super._notifierId = value;
    });
  }

  late final _$_messageAtom =
      Atom(name: '_NotificationModelStore._message', context: context);

  @override
  String get _message {
    _$_messageAtom.reportRead();
    return super._message;
  }

  @override
  set _message(String value) {
    _$_messageAtom.reportWrite(value, super._message, () {
      super._message = value;
    });
  }

  late final _$_isReadAtom =
      Atom(name: '_NotificationModelStore._isRead', context: context);

  @override
  bool get _isRead {
    _$_isReadAtom.reportRead();
    return super._isRead;
  }

  @override
  set _isRead(bool value) {
    _$_isReadAtom.reportWrite(value, super._isRead, () {
      super._isRead = value;
    });
  }

  late final _$_additionalAtom =
      Atom(name: '_NotificationModelStore._additional', context: context);

  @override
  Additional get _additional {
    _$_additionalAtom.reportRead();
    return super._additional;
  }

  @override
  set _additional(Additional value) {
    _$_additionalAtom.reportWrite(value, super._additional, () {
      super._additional = value;
    });
  }

  late final _$_createAtAtom =
      Atom(name: '_NotificationModelStore._createAt', context: context);

  @override
  DateTime get _createAt {
    _$_createAtAtom.reportRead();
    return super._createAt;
  }

  @override
  set _createAt(DateTime value) {
    _$_createAtAtom.reportWrite(value, super._createAt, () {
      super._createAt = value;
    });
  }

  late final _$_updatedAtAtom =
      Atom(name: '_NotificationModelStore._updatedAt', context: context);

  @override
  DateTime get _updatedAt {
    _$_updatedAtAtom.reportRead();
    return super._updatedAt;
  }

  @override
  set _updatedAt(DateTime value) {
    _$_updatedAtAtom.reportWrite(value, super._updatedAt, () {
      super._updatedAt = value;
    });
  }

  late final _$_typeAtom =
      Atom(name: '_NotificationModelStore._type', context: context);

  @override
  SessionTypeModel get _type {
    _$_typeAtom.reportRead();
    return super._type;
  }

  @override
  set _type(SessionTypeModel value) {
    _$_typeAtom.reportWrite(value, super._type, () {
      super._type = value;
    });
  }

  late final _$_NotificationModelStoreActionController =
      ActionController(name: '_NotificationModelStore', context: context);

  @override
  void read() {
    final _$actionInfo = _$_NotificationModelStoreActionController.startAction(
        name: '_NotificationModelStore.read');
    try {
      return super.read();
    } finally {
      _$_NotificationModelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
id: ${id},
typeId: ${typeId},
actorId: ${actorId},
notifierId: ${notifierId},
message: ${message},
isRead: ${isRead},
additional: ${additional},
createAt: ${createAt},
updatedAt: ${updatedAt},
type: ${type}
    ''';
  }
}
