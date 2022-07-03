// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotificationStore on _NotificationStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_NotificationStore.isLoading'))
          .value;
  Computed<NotificationFilter>? _$notificationFilterComputed;

  @override
  NotificationFilter get notificationFilter => (_$notificationFilterComputed ??=
          Computed<NotificationFilter>(() => super.notificationFilter,
              name: '_NotificationStore.notificationFilter'))
      .value;
  Computed<int>? _$notificationLengthListComputed;

  @override
  int get notificationLengthList => (_$notificationLengthListComputed ??=
          Computed<int>(() => super.notificationLengthList,
              name: '_NotificationStore.notificationLengthList'))
      .value;
  Computed<bool>? _$hasNotificationComputed;

  @override
  bool get hasNotification =>
      (_$hasNotificationComputed ??= Computed<bool>(() => super.hasNotification,
              name: '_NotificationStore.hasNotification'))
          .value;
  Computed<String>? _$getSuccessMessageKeyComputed;

  @override
  String get getSuccessMessageKey => (_$getSuccessMessageKeyComputed ??=
          Computed<String>(() => super.getSuccessMessageKey,
              name: '_NotificationStore.getSuccessMessageKey'))
      .value;
  Computed<String>? _$getFailedMessageKeyComputed;

  @override
  String get getFailedMessageKey => (_$getFailedMessageKeyComputed ??=
          Computed<String>(() => super.getFailedMessageKey,
              name: '_NotificationStore.getFailedMessageKey'))
      .value;

  late final _$successAtom =
      Atom(name: '_NotificationStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$_notificationFilterAtom =
      Atom(name: '_NotificationStore._notificationFilter', context: context);

  @override
  NotificationFilter get _notificationFilter {
    _$_notificationFilterAtom.reportRead();
    return super._notificationFilter;
  }

  @override
  set _notificationFilter(NotificationFilter value) {
    _$_notificationFilterAtom.reportWrite(value, super._notificationFilter, () {
      super._notificationFilter = value;
    });
  }

  late final _$requestFutureAtom =
      Atom(name: '_NotificationStore.requestFuture', context: context);

  @override
  ObservableFuture<Map<String, dynamic>?> get requestFuture {
    _$requestFutureAtom.reportRead();
    return super.requestFuture;
  }

  @override
  set requestFuture(ObservableFuture<Map<String, dynamic>?> value) {
    _$requestFutureAtom.reportWrite(value, super.requestFuture, () {
      super.requestFuture = value;
    });
  }

  late final _$notificationsAtom =
      Atom(name: '_NotificationStore.notifications', context: context);

  @override
  ObservableList<NotificationModel> get notifications {
    _$notificationsAtom.reportRead();
    return super.notifications;
  }

  @override
  set notifications(ObservableList<NotificationModel> value) {
    _$notificationsAtom.reportWrite(value, super.notifications, () {
      super.notifications = value;
    });
  }

  late final _$fetchAllNotificationsAsyncAction =
      AsyncAction('_NotificationStore.fetchAllNotifications', context: context);

  @override
  Future<void> fetchAllNotifications(
      [Map<String, dynamic> params = const {"limit": 20, "skip": 0}]) {
    return _$fetchAllNotificationsAsyncAction
        .run(() => super.fetchAllNotifications(params));
  }

  late final _$readAllUnreadedNotificationAsyncAction = AsyncAction(
      '_NotificationStore.readAllUnreadedNotification',
      context: context);

  @override
  Future<void> readAllUnreadedNotification() {
    return _$readAllUnreadedNotificationAsyncAction
        .run(() => super.readAllUnreadedNotification());
  }

  late final _$markNotificationAsReadAsyncAction = AsyncAction(
      '_NotificationStore.markNotificationAsRead',
      context: context);

  @override
  Future<void> markNotificationAsRead(int notificationId) {
    return _$markNotificationAsReadAsyncAction
        .run(() => super.markNotificationAsRead(notificationId));
  }

  late final _$_NotificationStoreActionController =
      ActionController(name: '_NotificationStore', context: context);

  @override
  void changeNotificationMethodFilter(NotificationFilter notificationFilter) {
    final _$actionInfo = _$_NotificationStoreActionController.startAction(
        name: '_NotificationStore.changeNotificationMethodFilter');
    try {
      return super.changeNotificationMethodFilter(notificationFilter);
    } finally {
      _$_NotificationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
success: ${success},
requestFuture: ${requestFuture},
notifications: ${notifications},
isLoading: ${isLoading},
notificationFilter: ${notificationFilter},
notificationLengthList: ${notificationLengthList},
hasNotification: ${hasNotification},
getSuccessMessageKey: ${getSuccessMessageKey},
getFailedMessageKey: ${getFailedMessageKey}
    ''';
  }
}
