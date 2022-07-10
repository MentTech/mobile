import 'package:mobile/data/repository.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/session/session.dart';
import 'package:mobile/models/common/session/sessions.dart';
import 'package:mobile/stores/message/message_store.dart';
import 'package:mobx/mobx.dart';
import 'package:mobile/utils/extension/datetime_extension.dart';

part 'schedule_store.g.dart';

class ScheduleStore = _ScheduleStore with _$ScheduleStore;

abstract class _ScheduleStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling error messages
  final MessageStore messageStore = getIt<MessageStore>();

  // constructor:---------------------------------------------------------------
  _ScheduleStore(Repository repository) : _repository = repository {
    // setting up disposers
    _setupDisposers();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
      // reaction((_) => triggerChange, (_) => triggerChange = false, delay: 200),
      // reaction(
      //   (_) => sessions,
      //   (_) {
      //     triggerChange = true;
      //   },
      // ),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<Map<String, dynamic>?> emptyLoginResponse =
      ObservableFuture.value(null);

  // store variables:-----------------------------------------------------------
  @observable
  bool success = false;

  @observable
  bool triggerChange = false;

  @observable
  ObservableFuture<Map<String, dynamic>?> requestNormalFuture =
      emptyLoginResponse;

  @observable
  ObservableFuture<Map<String, dynamic>?> requestCalendarFuture =
      emptyLoginResponse;

  @observable
  ObservableFuture<Map<String, dynamic>?> requestListFuture =
      emptyLoginResponse;

  @observable
  ObservableList<Session> sessionsByCalendar = ObservableList();

  @observable
  ObservableList<Session> sessionsByGroupList = ObservableList();

  // computed:------------------------------------------------------------------

  @computed
  bool get isLoading => requestNormalFuture.status == FutureStatus.pending;

  @computed
  bool get isCalendarLoading =>
      requestCalendarFuture.status == FutureStatus.pending;

  @computed
  bool get isListLoading => requestListFuture.status == FutureStatus.pending;

  @computed
  int get sizeCalendarSessions => sessionsByCalendar.length;

  @computed
  List<Session> get listCalendarSessions => sessionsByCalendar.toList();

  @computed
  int get sizeListSession => sessionsByGroupList.length;

  @computed
  List<Session> get listListSessions => sessionsByGroupList.toList();

  @computed
  String get getSuccessMessageKey => messageStore.successMessagekey;

  @computed
  String get getFailedMessageKey => messageStore.errorMessagekey;

  // actions:-------------------------------------------------------------------

  @action
  Future<void> fetchAllSessionsByList() async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.setErrorMessageByCode(401);

      success = false;

      return;
    }

    final future = _repository.fetchSessionsOfUser(
      authToken: accessToken,
      parameters: {
        "expectedStartDate": DateTime.now().toDDMMYYYYString(toUTC: true),
      },
    );

    requestListFuture = ObservableFuture(future);

    future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          // [TODO] implement here
          sessionsByGroupList = ObservableList.of(
              Sessions.fromJson(res).sessions.reversed.toList());

          success = true;
        } else {
          int code = res["statusCode"] as int;

          messageStore.setErrorMessageByCode(code);

          success = false;
        }
      } catch (e) {
        messageStore.setErrorMessageByCode(500);

        success = false;
      }
    });
  }

  @action
  Future<void> fetchSessionsByDate({required DateTime date}) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.setErrorMessageByCode(401);

      success = false;

      return;
    }

    final future = _repository.fetchSessionsOfUser(
      authToken: accessToken,
      parameters: {
        "expectedStartDate": date.today(toUTC: true).toIso8601String(),
        "expectedEndDate": date.tomorrow(toUTC: true).toIso8601String(),
      },
    );

    requestListFuture = ObservableFuture(future);

    await future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          // [TODO] implement here
          sessionsByCalendar = ObservableList.of(
              Sessions.fromJson(res).sessions.reversed.toList());

          success = true;
        } else {
          int code = res["statusCode"] as int;

          messageStore.setErrorMessageByCode(code);

          success = false;
        }
      } catch (e) {
        messageStore.setErrorMessageByCode(500);

        success = false;
      }
    });
  }

  @action
  Future<Session?> fetchSessionByID({required int sessionId}) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.setErrorMessageByCode(401);

      success = false;

      return null;
    }

    final future = _repository.fetchSession(
      authToken: accessToken,
      sessionId: sessionId,
    );
    requestNormalFuture = ObservableFuture(future);

    return await future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          Session session = Session.fromJson(res);

          success = true;

          return session;
        } else {
          int code = res["statusCode"] as int;

          messageStore.setErrorMessageByCode(code);

          success = false;

          return null;
        }
      } catch (e) {
        messageStore.setErrorMessageByCode(500);

        success = false;

        return null;
      }
    });
  }

  // general methods:-----------------------------------------------------------

  Session? getCalendarSessionsAt(int index) {
    if (index < sessionsByCalendar.length) {
      return sessionsByCalendar.elementAt(index);
    }
    return null;
  }

  Session? getListSessionsAt(int index) {
    if (index < sessionsByGroupList.length) {
      return sessionsByGroupList.elementAt(index);
    }
    return null;
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
