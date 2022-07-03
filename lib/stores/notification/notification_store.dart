import 'package:mobile/data/repository.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/notification/notification.dart';
import 'package:mobile/stores/message/message_store.dart';
import 'package:mobile/stores/notification/type_showing_notification.dart';
import 'package:mobx/mobx.dart';

part 'notification_store.g.dart';

class NotificationStore = _NotificationStore with _$NotificationStore;

abstract class _NotificationStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling error messages
  final MessageStore _messageStore = getIt<MessageStore>();

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
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<Map<String, dynamic>?> emptyResponse =
      ObservableFuture.value(null);

  // non-observable variables:--------------------------------------------------
  List<int> unreadedMessageIds = [];

  // observable variables:------------------------------------------------------
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

  // actions:-------------------------------------------------------------------
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

          for (NotificationModel noti in notifications) {
            if (!noti.isRead) {
              unreadedMessageIds.add(noti.id);
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

    requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          for (var noti in notifications) {
            noti = noti.toReadedModel();
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

    requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        if (res!["statusCode"] == null) {
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
  }
}
