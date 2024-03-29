import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mobile/data/repository.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/session/session.dart';
import 'package:mobile/models/common/session/sessions.dart';
import 'package:mobile/models/common/transaction/transaction.dart';
import 'package:mobile/models/user/user.dart';
import 'package:mobile/stores/enum/session_status_enum.dart';
import 'package:mobile/stores/enum/status_type_enum.dart';
import 'package:mobile/stores/message/message_store.dart';
import 'package:mobx/mobx.dart';
import 'package:mobile/utils/extension/datetime_extension.dart';
import 'package:tuple/tuple.dart';

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
      // reaction((_) => triggerChange, (_) => triggerChange = false, delay: 200),
      reaction(
        (_) => sessions,
        (_) {
          // triggerChange = true;
          // log("[reaction] message trigger reaction");
        },
        // equals: (ObservableList<Session>? l1, ObservableList<Session>? l2) {
        //   log("work? " +
        //       ((null == l1 || null == l2).toString() +
        //           ((l1?.length ?? 0) != (l2?.length ?? 1)).toString()));
        //   if (null == l1 || null == l2) {
        //     return true;
        //   }

        //   if (l1.length != l2.length) {
        //     return true;
        //   }

        //   // if l1.length == l2.length
        //   int count = l1.length;
        //   for (var i = 0; i < count; i++) {
        //     if (l1.elementAt(i) != l2.elementAt(i)) {
        //       return true;
        //     }
        //   }
        //   log("false");
        //   return false;
        // },
      ),
      // reaction((_) => accessToken, (_) => accessToken = null, delay: 200),
      // reaction((_) => requestFuture.status, (FutureStatus status) {
      //   if (status == FutureStatus.fulfilled) {
      //     if (callback != null) {
      //       callback!.call(success);
      //       callback = null;
      //     }
      //   }
      // }),
      reaction((_) => transactionStatus, (_) {
        // log("[reaction] message trigger reaction");
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
  int balance = 0;

  @observable
  Status sessionStatus = Status.all;

  @observable
  StatusType? transactionStatus;

  @observable
  SessionFetchingData sessionFetchingData = SessionFetchingData();

  List<Session> originSessions = [];

  @observable
  Session? session;

  @observable
  ObservableList<Session> sessions = ObservableList();

  @observable
  ObservableList<Session> nextSessions = ObservableList<Session>();

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
  int get sizeNextSessionList => nextSessions.length;

  @computed
  int get sizeTransactionList => _transactionContent?.transactions.length ?? 0;

  @computed
  String get getSuccessMessageKey => messageStore.successMessagekey;

  @computed
  String get getFailedMessageKey => messageStore.errorMessagekey;

  @computed
  Status get currentSessionFetchStatus => sessionStatus;

  @computed
  StatusType? get currentTransactionFetchStatus => transactionStatus;

  @computed
  List<double> get toPieChart {
    // if (_transactionContent != null) {
    //   int countSuccess = _transactionContent!.transactions
    //       .where((element) => element.status == StatusType.SUCCESS)
    //       .toList()
    //       .length;

    //   double percent =
    //       countSuccess * 1.0 / _transactionContent!.transactions.length * 100;

    //   return [percent, 100 - percent];
    // }

    if (_transactionContent != null) {
      int countSuccess = _transactionContent!.transactions
          .where((element) => element.amount > 0)
          .toList()
          .length;

      double percent =
          countSuccess * 1.0 / _transactionContent!.transactions.length * 100;

      return [percent, 100 - percent];
    }

    // if (_transactionContent != null) {
    //   int total = 0;
    //   int sum = 0;

    //   for (var element in _transactionContent!.transactions) {
    //     if (element.amount > 0) {
    //       sum += element.amount;
    //     }
    //     total += element.amount;
    //   }

    //   double percent = (sum * 1.0 / total).roundToDouble();

    //   return [percent, 100 - percent];
    // }

    return [];
  }

  @computed
  Map<DateTime, Tuple2<double, double>> get toBarChart {
    Map<DateTime, Tuple2<double, double>> result = {};

    if (_transactionContent != null) {
      for (var element in _transactionContent!.transactions) {
        DateTime elementDate = element.createAt.today();

        if (result.containsKey(elementDate)) {
          if (element.amount < 0) {
            result[elementDate] = result[elementDate]!
                .withItem2(result[elementDate]!.item2 - element.amount);
          } else {
            result[elementDate] = result[elementDate]!
                .withItem1(result[elementDate]!.item1 + element.amount);
          }
        } else {
          if (element.amount < 0) {
            result[elementDate] = Tuple2(0, -element.amount.toDouble());
          } else {
            result[elementDate] = Tuple2(element.amount.toDouble(), 0);
          }
        }
      }

      result.forEach((key, value) {
        result[key] = value
            .withItem1((value.item1 / 1000))
            .withItem2((value.item2 / 1000));
      });
    }

    return result;
  }

  Session? getNextSessionAt(int index) {
    if (index < nextSessions.length) {
      return nextSessions.elementAt(index);
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
  Session? getSessionAt(int index) {
    if (index < sessions.length) {
      return sessions.elementAt(index);
    }
    return null;
  }

  @action
  void updateSessionStatus(Status sessionStatus) {
    this.sessionStatus = sessionStatus;
    sessionFetchingData.updateStatus(sessionStatus);

    sessions.clear();
    for (Session session in originSessions) {
      if (sessionFetchingData.checkSameStatus(session)) {
        sessions.add(session);
      }
    }
    sessions = ObservableList.of(sessions.reversed);
  }

  @action
  void updateTransactionStatus(StatusType? transactionStatus) {
    this.transactionStatus = transactionStatus;
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
        if (res!["statusCode"] == null) {
          user = UserModel.fromJson(res);

          balance = user!.coin;

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

      return success;
    });

    return Future.value(success);
  }

  @action
  Future<bool> fetchMyTransactions() async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      return false;
    }

    final future = _repository.fetchTransactions(authToken: accessToken);
    requestTransactionFuture = ObservableFuture(future);

    return await future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          TransactionContent transactionContent =
              TransactionContent.fromJson(res);

          _transactionContent = TransactionContent(
              balance: transactionContent.balance,
              transactions: transactionContent.transactions.reversed.toList());

          balance = transactionContent.balance;

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

      return success;
    });
  }

  @action
  Future<void> fetchFavouriteMentors({VoidCallback? callback}) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.setErrorMessageByCode(401);

      success = false;

      return;
    }

    final future = _repository.fetchFavouriteMentors(authToken: accessToken);

    future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          favouriteMentorIdList.addAll(res["ids"]!.cast<int>());

          callback?.call();

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
  Future<bool> fetchUserSessions() async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.setErrorMessageByCode(401);

      success = false;
      return Future.value(false);
    }

    sessionStatus = Status.all;
    sessionFetchingData.updateStatus(sessionStatus);

    final future = _repository.fetchSessionsOfUser(
      authToken: accessToken,
      // parameters: sessionFetchingData.toMapJson(),
    );
    requestSessionFuture = ObservableFuture(future);

    return await future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          originSessions = Sessions.fromJson(res).sessions;
          sessions = ObservableList.of(originSessions.reversed);

          success = true;
        } else {
          int code = res["statusCode"] as int;

          messageStore.setErrorMessageByCode(code);

          success = false;
        }

        return Future.value(success);
      } catch (e) {
        messageStore.setErrorMessageByCode(500);

        success = false;
        return Future.value(false);
      }
    });
  }

  @action
  Future<void> fetchNextSessions() async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.setErrorMessageByCode(401);

      success = false;

      return;
    }

    final future = _repository.fetchSessionsOfUser(
      authToken: accessToken,
      parameters: {
        "expectedStartDate": DateTime.now().toDDMMYYYYString(),
      },
    );

    requestSessionFuture = ObservableFuture(future);

    future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          // [TODO] implement here
          nextSessions = ObservableList.of(
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
      return false;
    }

    final Future<Map<String, dynamic>?> future =
        _repository.uploadUserAvatar(authToken: accessToken, image: imageFile);

    requestUploadAvatarFuture = ObservableFuture(future);

    return await future.then((res) {
      try {
        if (res!["statusCode"] == null) {
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

      return success;
    });
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

          success = false;
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

  void updateStatus(Status sessionStatus) {
    switch (sessionStatus) {
      case Status.waiting:
        isAll = false;
        isAccepted = false;
        isDone = false;
        isCanceled = false;
        break;
      case Status.confirmed:
        isAll = false;
        isAccepted = true;
        isDone = false;
        isCanceled = false;
        break;
      case Status.completed:
        isAll = false;
        isAccepted = true;
        isDone = true;
        isCanceled = false;
        break;
      case Status.canceled:
        isAll = false;
        isAccepted = false;
        isDone = true;
        isCanceled = true;
        break;
      default: // Status.all
        isAll = true;
        isAccepted = false;
        isDone = false;
        isCanceled = false;
        break;
    }
  }

  static Status parseSessionStatus(Session session) {
    if (session.isCanceled) {
      return Status.canceled;
    } else if (session.done) {
      return Status.completed;
    } else if (session.isAccepted) {
      return Status.confirmed;
    } else {
      return Status.waiting;
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
