import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mobile/data/repository.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/session/session.dart';
import 'package:mobile/models/common/session/sessions.dart';
import 'package:mobile/models/common/transaction/transaction.dart';
import 'package:mobile/models/user/user.dart';
import 'package:mobile/stores/enum/session_status_enum.dart';
import 'package:mobile/stores/message/message_store.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling error messages
  final MessageStore messageStore = getIt<MessageStore>();

  // constructor:---------------------------------------------------------------
  _UserStore(Repository repository) : _repository = repository {
    // setting up disposers
    _setupDisposers();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
      // reaction((_) => accessToken, (_) => accessToken = null, delay: 200),
      // reaction((_) => requestFuture.status, (FutureStatus status) {
      //   if (status == FutureStatus.fulfilled) {
      //     if (callback != null) {
      //       callback!.call(success);
      //       callback = null;
      //     }
      //   }
      // }),
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
  ObservableFuture<Map<String, dynamic>?> requestUploadAvatarFuture =
      emptyLoginResponse;

  @observable
  ObservableFuture<Map<String, dynamic>?> requestFavEventFuture =
      emptyLoginResponse;

  @observable
  ObservableFuture<Map<String, dynamic>?> requestSessionFuture =
      emptyLoginResponse;

  @observable
  ObservableFuture<Map<String, dynamic>?> requestTransactionFuture =
      emptyLoginResponse;

  @observable
  UserModel? user;

  @observable
  SessionStatus sessionStatus = SessionStatus.all;

  @observable
  SessionFetchingData sessionFetchingData = SessionFetchingData();

  List<Session> originSessions = [];

  @observable
  Session? session;

  @observable
  ObservableList<Session> sessions = ObservableList();

  @observable
  TransactionContent? _transactionContent;

  List<int> favouriteMentorIdList = [];

  // computed:------------------------------------------------------------------

  @computed
  bool get isLoading => requestFuture.status == FutureStatus.pending;

  @computed
  bool get isUploadingAvatar =>
      requestUploadAvatarFuture.status == FutureStatus.pending;

  @computed
  bool get isPushingFavMentorData =>
      requestFavEventFuture.status == FutureStatus.pending;

  @computed
  bool get isSessionLoading =>
      requestSessionFuture.status == FutureStatus.pending;

  @computed
  bool get isTransactionLoading =>
      requestTransactionFuture.status == FutureStatus.pending;

  @computed
  Session? get getSession => session;

  @computed
  bool get hasSession => session != null;

  @computed
  int get sizeSessionList => sessions.length;

  @computed
  int get sizeTransactionList => _transactionContent?.transactions.length ?? 0;

  @computed
  String get getSuccessMessageKey => messageStore.successMessagekey;

  @computed
  String get getFailedMessageKey => messageStore.errorMessagekey;

  SessionStatus get currentSessionFetchStatus => sessionStatus;

  Session? getSessionAt(int index) {
    if (index < sessions.length) {
      return sessions.elementAt(index);
    }
    return null;
  }

  Transaction? getTransactionAt(int index) {
    if (index < (_transactionContent?.transactions.length ?? 0)) {
      return _transactionContent!.transactions.elementAt(index);
    }
    return null;
  }

  int getFavIdAt(int index) => favouriteMentorIdList.elementAt(index);

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

    await future.then((res) {
      try {
        user = UserModel.fromJson(res!);
        success = true;
      } catch (e) {
        // res['message']
        success = false;
      }
    });

    return Future.value(success);
  }

  @action
  Future<void> fetchMyTransactions() async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      return;
    }

    final future = _repository.fetchTransactions(authToken: accessToken);
    requestTransactionFuture = ObservableFuture(future);

    future.then((res) {
      try {
        TransactionContent transactionContent =
            TransactionContent.fromJson(res!);
        _transactionContent = TransactionContent(
            balance: transactionContent.balance,
            transactions: transactionContent.transactions.reversed.toList());

        success = true;
        return Future.value(true);
      } catch (e) {
        // res['message']
        success = false;
        return Future.value(false);
      }
    });
  }

  @action
  Future<void> fetchFavouriteMentors({VoidCallback? callback}) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      success = false;
    }

    final future = _repository.fetchFavouriteMentors(authToken: accessToken!);

    future.then((res) {
      favouriteMentorIdList.addAll(res!["ids"]!.cast<int>());

      callback?.call();
      try {
        success = true;
      } catch (e) {
        success = false;
      }
    });
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
    requestSessionFuture = ObservableFuture(future);

    await future.then((res) {
      try {
        originSessions = Sessions.fromJson(res!).sessions;
        sessions = ObservableList.of(originSessions.reversed.toList());
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
  Future<void> fetchSession({required int sessionId}) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.setErrorMessageByCode(401);

      success = false;

      return;
    }

    session = null;

    final future = _repository.fetchSession(
      authToken: accessToken,
      sessionId: sessionId,
    );
    requestSessionFuture = ObservableFuture(future);

    await future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          session = Session.fromJson(res);

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
  Future<bool> callUpdateFavMentor({required int mentorID}) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      return Future.value(false);
    }

    final Future<Map<String, dynamic>?> future;
    final bool existedMentor;
    if (favouriteMentorIdList.contains(mentorID)) {
      existedMentor = true;
      future = _repository.removeFavouriteMentor(
          authToken: accessToken, mentorId: mentorID);
    } else {
      existedMentor = false;
      future = _repository.addFavouriteMentor(
          authToken: accessToken, mentorId: mentorID);
    }

    requestFavEventFuture = ObservableFuture(future);

    await future.then((res) {
      try {
        if (existedMentor) {
          favouriteMentorIdList.remove(mentorID);
        } else {
          favouriteMentorIdList.add(mentorID);
        }

        success = true;
        return Future.value(true);
      } catch (e) {
        // res['message']
        success = false;
        return Future.value(false);
      }
    });

    return Future.value(true);
  }

  @action
  Future<bool> uploadUserAvatar({required File imageFile}) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      return Future.value(false);
    }

    final Future<Map<String, dynamic>?> future =
        _repository.uploadUserAvatar(authToken: accessToken, image: imageFile);

    requestUploadAvatarFuture = ObservableFuture(future);

    future.then((res) {
      try {
        success = true;
        return Future.value(true);
      } catch (e) {
        // res['message']
        success = false;
        return Future.value(false);
      }
    });

    return Future.value(true);
  }

  @action
  Future<void> updateUserInformation(
      {required Map<String, String> data}) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      return;
    }

    final Future<Map<String, dynamic>?> future =
        _repository.updateUserInformation(authToken: accessToken, data: data);

    requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          messageStore.setSuccessMessage(Code.updateUserInfor);
          user = UserModel.fromJson(res);

          success = true;
        } else {
          int code = res["statusCode"] as int;

          messageStore.setErrorMessageByCode(code);

          success = false;
        }
      } catch (e) {
        // int code = mapJson["statusCode"] as int;
        // messageStore.setErrorMessageByCode(code);
        // res['message']
        success = false;
      }
    });
  }

  @action
  Future<void> applyGiftcode({required Map<String, String> data}) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.setErrorMessageByCode(401);

      return;
    }

    final Future<Map<String, dynamic>?> future =
        _repository.applyGiftcode(authToken: accessToken, data: data);

    requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          messageStore.setSuccessMessage(Code.applyGiftcode);

          success = true;
        } else {
          int code = res["statusCode"] as int;

          messageStore.setErrorMessageByCode(code);
        }
      } catch (e) {
        messageStore.setErrorMessageByCode(304);
        success = false;
      }
    });
  }

  // general methods:-----------------------------------------------------------
  bool checkIsLikedMentor(int mentorId) {
    return favouriteMentorIdList.contains(mentorId);
  }

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
