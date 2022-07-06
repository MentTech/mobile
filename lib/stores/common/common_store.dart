import 'package:flutter/widgets.dart';
import 'package:mobile/data/repository.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/session/session.dart';
import 'package:mobile/models/rate/rate.dart';
import 'package:mobile/stores/message/message_store.dart';
import 'package:mobx/mobx.dart';

part 'common_store.g.dart';

class CommonStore = _CommonStore with _$CommonStore;

abstract class _CommonStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling error messages
  final MessageStore messageStore = getIt<MessageStore>();

  // constructor:---------------------------------------------------------------
  _CommonStore(Repository repository) : _repository = repository {
    // setting up disposers
    _setupDisposers();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;
  VoidCallback? callback;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
      reaction((_) => successInRegisterProgram,
          (_) => successInRegisterProgram = false,
          delay: 200),
      reaction((_) => requestFuture.status, (FutureStatus status) {
        if (status == FutureStatus.fulfilled) {
          if (callback != null) {
            callback!.call();
            callback = null;
            requestFuture = emptyResponse;
          }
        }
      }),
      reaction((_) => requestRegisterSessionFuture.status,
          (FutureStatus status) {
        if (status == FutureStatus.fulfilled) {}
      }),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<Map<String, dynamic>?> emptyResponse =
      ObservableFuture.value(null);

  // non-observable variables:--------------------------------------------------
  final int totalPage = 0;

  int programRatePage = 0;

  // observable variables:------------------------------------------------------
  @observable
  bool success = false;

  @observable
  bool successInRegisterProgram = false;

  @observable
  ObservableFuture<Map<String, dynamic>?> requestFuture = emptyResponse;

  @observable
  ObservableFuture<Map<String, dynamic>?> requestRegisterSessionFuture =
      emptyResponse;

  @observable
  ObservableList<RateModel> rateModels = ObservableList<RateModel>();

  @observable
  Session? session;

  // computed:------------------------------------------------------------------
  @computed
  bool get isLoading => requestFuture.status == FutureStatus.pending;

  @computed
  bool get isRegistering =>
      requestRegisterSessionFuture.status == FutureStatus.pending;

  @computed
  bool get isRegisteringDone =>
      (requestRegisterSessionFuture.status == FutureStatus.fulfilled);

  @computed
  int get programLengthList => rateModels.length;

  @computed
  Session? get sessionObserver => session;

  @computed
  String get getSuccessMessageKey => messageStore.successMessagekey;

  @computed
  String get getFailedMessageKey => messageStore.errorMessagekey;

  // actions:-------------------------------------------------------------------
  @action
  bool nextProgramRatePage() {
    if (programRatePage + 1 <= totalPage) {
      programRatePage++;

      return true;
    }
    return false;
  }

  @action
  bool prevProgramRatePage() {
    // init and do not have any data
    if (0 == programRatePage) {
      programRatePage++;
      return true;
    }

    if (programRatePage - 1 > 0) {
      programRatePage--;

      return true;
    }
    return false;
  }

  @action
  Future<void> fetchProgramRateList(int mentorID, int programID) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.setErrorMessageByCode(401);

      success = false;

      return;
    }

    final future = _repository.fetchProgramRateList(
      mentorID: mentorID,
      programID: programID,
      query: {
        "limit": 6,
        "page": programRatePage,
      },
    );
    requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        rateModels = ObservableList.of(RateModelList.fromJson(res!).rateModels);

        success = true;
      } catch (e) {
        // res['message']
        // messageStore.errorMessage = e.toString();
        // messageStore.successMessage =
        //     "[fetchProgramRate] error to get Program Rate List";

        success = false;
      }
    });
  }

  @action
  Future<void> registerProgramOfMentor({
    required int mentorID,
    required int programID,
    required Map<String, String> body,
  }) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.setErrorMessageByCode(401);

      success = false;

      return;
    }

    final future = _repository.registerProgram(
      authToken: accessToken,
      mentorID: mentorID,
      programID: programID,
      body: body,
    );
    requestRegisterSessionFuture = ObservableFuture(future);

    future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          // program parser

          successInRegisterProgram = true;
        } else {
          int code = res["statusCode"] as int;

          messageStore.setErrorMessageByCode(code);

          successInRegisterProgram = false;
        }
      } catch (e) {
        messageStore.setErrorMessageByCode(500);

        successInRegisterProgram = false;
      }
    });
  }

  @action
  Future<void> unregisterSessionOfProgram({
    VoidCallback? callback,
  }) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.setErrorMessageByCode(401);
      messageStore.notifyExpiredTokenStatus();

      success = false;

      return;
    }

    final future = _repository.unregisterASessionOfProgram(
      mentorID: session!.program.mentorId,
      programID: session!.program.id,
      sessionID: session!.id,
      authToken: accessToken,
    );
    requestRegisterSessionFuture = ObservableFuture(future);

    future.then(
      (res) {
        try {
          callback?.call();
          success = true;
        } catch (e) {
          // res['message']
          // messageStore.errorMessage = e.toString();
          // messageStore.successMessage = "";

          success = false;
        }
      },
    );
  }

  @action
  Future<void> markSessionOfProgramAsDone() async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.setErrorMessageByCode(401);
      messageStore.notifyExpiredTokenStatus();

      success = false;

      return;
    }

    final future = _repository.markSessionOfProgramAsDone(
      mentorID: session!.program.mentorId,
      programID: session!.program.id,
      sessionID: session!.id,
      authToken: accessToken,
    );
    requestFuture = ObservableFuture(future);

    future.then(
      (res) {
        try {
          success = true;
        } catch (e) {
          // res['message']
          // messageStore.errorMessage = e.toString();
          // messageStore.successMessage = "";

          success = false;
        }
      },
    );
  }

  @action
  Future<void> reviewSessionOfProgram(ReviewModel reviewModel) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.setErrorMessageByCode(401);
      messageStore.notifyExpiredTokenStatus();

      success = false;

      return;
    }

    final future = _repository.reviewSessionOfProgram(
      mentorID: session!.program.mentorId,
      programID: session!.program.id,
      sessionID: session!.id,
      authToken: accessToken,
      rate: reviewModel.rate,
      comment: reviewModel.comment,
    );
    requestFuture = ObservableFuture(future);

    future.then(
      (res) {
        try {
          success = true;
        } catch (e) {
          // res['message']
          // messageStore.errorMessage = e.toString();
          // messageStore.successMessage = "";

          success = false;
        }
      },
    );
  }

  @action
  void setSessionObserver(Session session) {
    this.session = session;
  }

  // general methods:-----------------------------------------------------------

  RateModel getRateCommentAt(int index) => rateModels.elementAt(index);

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

class ReviewModel {
  final int rate;
  final String comment;

  ReviewModel({
    required this.rate,
    required this.comment,
  });
}
