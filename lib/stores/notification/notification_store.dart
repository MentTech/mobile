import 'dart:developer';

import 'package:mobile/data/network/constants/endpoints.dart';
import 'package:mobile/data/repository.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/notification/notification.dart';
import 'package:mobile/stores/message/message_store.dart';
import 'package:mobile/stores/notification/type_showing_notification.dart';
import 'package:mobx/mobx.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

part 'notification_store.g.dart';

class NotificationStore = _NotificationStore with _$NotificationStore;

abstract class _NotificationStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling error messages
  final MessageStore _messageStore = getIt<MessageStore>();

  // websocket
  io.Socket socket = io.io(
    Endpoints.apiUrl,
    io.OptionBuilder()
        .setTimeout(5000)
        .disableAutoConnect()
        .setTransports(['websocket']).build(),
  );

  // constructor:---------------------------------------------------------------
  _NotificationStore(Repository repository) : _repository = repository {
    // setting up disposers
    _setupDisposers();

    // fetch all notifications when start app
    // fetchAllNotifications();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
      reaction((_) => trigger, (_) => trigger = false, delay: 200),
    ];
  }

  // connect to server by websocket
  Future connectSocket() async {
    // socket setup
    await _repository.authToken.then((accessToken) {
      if (accessToken != null && accessToken.isNotEmpty) {
        log("[message] [socket io] set up");

        socket.connect();

        socket.emit('auth:connect', accessToken);

        socket.onConnect((data) {
          log("[socket io] connected " + socket.connected.toString());
          log('[socket io] onConnect: ' + data.toString());
        });

        socket.onConnectError((data) {
          log("[socket io] [onConnectError] " + data.toString());
        });

        socket.onError((data) {
          log("[socket io] [onError] " + data.toString());
        });

        // listen event
        socket.on('notification', (data) {
          log("[socket io] data from notification event " + data.toString());
          addNewNotification(data);
        });
      } else {
        _messageStore.setErrorMessageByCode(401);

        socket.dispose();

        success = false;
      }
    });
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<Map<String, dynamic>?> emptyResponse =
      ObservableFuture.value(null);

  // non-observable variables:--------------------------------------------------
  List<int> unreadedMessageIds = [];

  List<NotificationModel> unreadedNotifications = <NotificationModel>[];

  // observable variables:------------------------------------------------------
  @observable
  bool trigger = false;

  @observable
  bool success = false;

  @observable
  // ignore: prefer_final_fields
  NotificationFilter _notificationFilter = NotificationFilter.all;

  @observable
  ObservableFuture<Map<String, dynamic>?> requestFuture = emptyResponse;

  @observable
  ObservableList<NotificationModel> notifications =
      ObservableList<NotificationModel>();

  // computed:------------------------------------------------------------------
  @computed
  bool get isLoading => requestFuture.status == FutureStatus.pending;

  @computed
  NotificationFilter get notificationFilter => _notificationFilter;

  @computed
  int get notificationLengthList => notifications.length;

  @computed
  bool get hasNotification => notifications.isNotEmpty;

  @computed
  String get getSuccessMessageKey => _messageStore.successMessagekey;

  @computed
  String get getFailedMessageKey => _messageStore.errorMessagekey;

  @computed
  List<NotificationModel> get getFilteredNotificationList {
    if (_notificationFilter == NotificationFilter.all) {
      return notifications;
    } else {
      // NotificationFilter.unread
      return unreadedNotifications;
    }
  }

  // actions:-------------------------------------------------------------------
  @action
  void addNewNotification(dynamic data) {
    notifications.add(NotificationModel.fromJson(data));
    trigger = true;
  }

  @action
  void changeNotificationMethodFilter(NotificationFilter notificationFilter) {
    _notificationFilter = notificationFilter;
  }

  @action
  Future<void> fetchAllNotifications([
    Map<String, dynamic> params = const {
      "limit": 20,
      "skip": 0,
    },
  ]) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      _messageStore.setErrorMessageByCode(401);

      success = false;

      return;
    }

    final future = _repository.fetchAllNotifications(
      authToken: accessToken,
      params: params,
    );

    requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          notifications =
              ObservableList.of(NotificationList.fromJson(res).notifications);

          unreadedMessageIds.clear();
          unreadedNotifications.clear();
          for (NotificationModel noti in notifications) {
            if (!noti.isRead) {
              unreadedMessageIds.add(noti.id);
              unreadedNotifications.add(noti);
            }
          }

          success = true;
        } else {
          int code = res["statusCode"] as int;

          _messageStore.setErrorMessageByCode(code);

          success = false;
        }
      } catch (e) {
        _messageStore.setErrorMessageByCode(500);

        success = false;
      }
    });
  }

  @action
  Future<void> readAllUnreadedNotification() async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      _messageStore.setErrorMessageByCode(401);

      success = false;

      return;
    }

    final future = _repository.markMultiNotificationsAsRead(
      authToken: accessToken,
      markReadedIds: unreadedMessageIds,
    );

    // requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          for (var noti in notifications) {
            noti = noti.toReadedModel();
          }

          unreadedMessageIds = [];

          success = true;
        } else {
          int code = res["statusCode"] as int;

          _messageStore.setErrorMessageByCode(code);

          success = false;
        }
      } catch (e) {
        _messageStore.setErrorMessageByCode(500);

        success = false;
      }
    });
  }

  @action
  Future<void> markNotificationAsRead(int notificationId) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      _messageStore.setErrorMessageByCode(401);

      success = false;

      return;
    }

    final future = _repository.markNotificationAsRead(
      authToken: accessToken,
      notificationId: notificationId,
    );

    // requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          for (var noti in notifications) {
            if (noti.id == notificationId) {
              noti = noti.toReadedModel();
              break;
            }
          }

          unreadedMessageIds.remove(notificationId);

          success = true;
        } else {
          int code = res["statusCode"] as int;

          _messageStore.setErrorMessageByCode(code);

          success = false;
        }
      } catch (e) {
        _messageStore.setErrorMessageByCode(500);

        success = false;
      }
    });
  }

  // general methods:-----------------------------------------------------------

  NotificationModel getNotificationContentAt(int index) =>
      notifications.elementAt(index);

  void dispose() {
    for (final d in _disposers) {
      d();
    }

    // disconnect to websocket
  }
}
