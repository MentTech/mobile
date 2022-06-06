import 'package:flutter/foundation.dart';
import 'package:mobile/data/repository.dart';
import 'package:mobile/models/common/session/session.dart';
import 'package:mobile/models/common/session/sessions.dart';
import 'package:mobile/models/user/user.dart';
import 'package:mobile/stores/enum/session_status_enum.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling form errors
  // final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  // final MessageStore messageStore = MessageStore();

  // function callback
  ValueChanged<bool>? callback;

  // constructor:---------------------------------------------------------------
  _UserStore(Repository repository) : _repository = repository {
    // setting up disposers
    _setupDisposers();

    // checking if user is logged in
    // repository.authToken.then((value) {
    //   accessToken = value;
    // });
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      // reaction((_) => success, (_) => success = false, delay: 200),
      // reaction((_) => accessToken, (_) => accessToken = null, delay: 200),
      reaction((_) => requestFuture.status, (FutureStatus status) {
        if (status == FutureStatus.fulfilled) {
          if (callback != null) {
            callback!.call(success);
            callback = null;
          }
        }
      }),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<Map<String, dynamic>?> emptyLoginResponse =
      ObservableFuture.value(null);

  // store variables:-----------------------------------------------------------
  @observable
  bool success = false;

  @observable
  ObservableFuture<Map<String, dynamic>?> requestFuture = emptyLoginResponse;

  @observable
  UserModel? user;

  @observable
  SessionStatus sessionStatus = SessionStatus.all;

  @observable
  SessionFetchingData sessionFetchingData = SessionFetchingData();

  List<Session> originSessions = [];

  @observable
  ObservableList<Session> sessions = ObservableList();

  @computed
  bool get isLoading => requestFuture.status == FutureStatus.pending;

  @computed
  int get sizeSessionList => sessions.length;

  SessionStatus get currentSessionFetchStatus => sessionStatus;

  Session getSessionAt(int index) => sessions.elementAt(index);

  // actions:-------------------------------------------------------------------
  @action
  void updateSessionStatus(SessionStatus sessionStatus) {
    this.sessionStatus = sessionStatus;
    sessionFetchingData.updateStatus(sessionStatus);

    sessions.clear();
    for (Session session in originSessions) {
      if (sessionFetchingData.checkSameStatus(session)) {
        sessions.add(session);
      }
    }
  }

  @action
  Future<bool> fetchUserInfor() async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      return Future.value(false);
    }

    final future = _repository.fetchUserInfor(accessToken);
    requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        user = UserModel.fromJson(res!);
        success = true;
        return Future.value(true);
      } catch (e) {
        // res['message']
        success = false;
        return Future.value(false);
      }
    });

    return Future.value(false);
  }

  @action
  Future<bool> fetchUserSessions() async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      return Future.value(false);
    }

    final future = _repository.fetchSessionsOfUser(
      authToken: accessToken,
      // parameters: sessionFetchingData.toMapJson(),
    );
    requestFuture = ObservableFuture(future);

    await future.then((res) {
      try {
        originSessions = Sessions.fromJson(res!).sessions;
        sessions = ObservableList.of(originSessions);
        success = true;
        return Future.value(true);
      } catch (e) {
        // res['message']
        success = false;
        return Future.value(false);
      }
    });

    return Future.value(false);
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

class SessionFetchingData {
  bool isCanceled = false;
  bool isAccepted = false;
  bool isDone = false;
  bool isAll = false;

  void updateStatus(SessionStatus sessionStatus) {
    switch (sessionStatus) {
      case SessionStatus.confirmed:
        isAll = false;
        isCanceled = false;
        isAccepted = true;
        isDone = false;
        break;
      case SessionStatus.completed:
        isAll = false;
        isCanceled = false;
        isAccepted = true;
        isDone = true;
        break;
      case SessionStatus.canceled:
        isAll = false;
        isCanceled = true;
        isAccepted = false;
        isDone = true;
        break;
      case SessionStatus.waiting:
        isAll = false;
        isCanceled = false;
        isAccepted = false;
        isDone = false;
        break;
      default: // SessionStatus.all
        isAll = true;
        isCanceled = false;
        isAccepted = false;
        isDone = false;
        break;
    }
  }

  static SessionStatus parseSessionStatus(Session session) {
    if (session.isCanceled) {
      return SessionStatus.canceled;
    } else if (session.done) {
      return SessionStatus.completed;
    } else if (session.isAccepted) {
      return SessionStatus.confirmed;
    } else {
      return SessionStatus.waiting;
    }
  }

  bool checkSameStatus(Session session) {
    return (isAll) ||
        (isCanceled == session.isCanceled &&
            isAccepted == session.isAccepted &&
            isDone == session.done);
  }

  Map<String, dynamic> toMapJson() {
    return {
      "isCanceled": isCanceled,
      "isAccepted": isAccepted,
      "done": isDone,
    };
  }
}
