import 'package:flutter/widgets.dart';
import 'package:mobile/data/repository.dart';
import 'package:mobile/models/rate/rate.dart';
import 'package:mobile/stores/message/message_store.dart';
import 'package:mobx/mobx.dart';

part 'common_store.g.dart';

class CommonStore = _CommonStore with _$CommonStore;

abstract class _CommonStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling error messages
  final MessageStore messageStore = MessageStore();

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
      reaction((_) => requestFuture.status, (FutureStatus status) {
        if (status == FutureStatus.fulfilled) {
          if (callback != null) {
            callback!.call();
            callback = null;
            requestFuture = emptyResponse;
          }
        }
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
  ObservableFuture<Map<String, dynamic>?> requestFuture = emptyResponse;

  @observable
  ObservableList<RateModel> rateModels = ObservableList<RateModel>();

  // computed:------------------------------------------------------------------
  @computed
  bool get isLoading => requestFuture.status == FutureStatus.pending;

  @computed
  get programLengthList => rateModels.length;

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
      messageStore.successMessage = "";
      messageStore.errorMessage = "There are no AccessToken";
      messageStore.notifyExpiredTokenStatus();

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
        messageStore.errorMessage = e.toString();
        messageStore.successMessage =
            "[fetchProgramRate] error to get Program Rate List";

        success = false;
      }
    });
  }

  @action
  Future<bool?> registerProgramOfMentor({
    required int mentorID,
    required int programID,
    required Map<String, String> body,
  }) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.successMessage = "";
      messageStore.errorMessage = "There are no AccessToken";
      messageStore.notifyExpiredTokenStatus();

      success = false;

      return null;
    }

    final future = _repository.registerProgram(
      mentorID: mentorID,
      programID: programID,
      body: body,
    );
    requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        rateModels = ObservableList.of(RateModelList.fromJson(res!).rateModels);

        success = true;
      } catch (e) {
        // res['message']
        messageStore.errorMessage = e.toString();
        messageStore.successMessage =
            "[fetchProgramRate] error to get Program Rate List";

        success = false;
      }
    });

    return true;
  }

  // general methods:-----------------------------------------------------------

  RateModel getProgramAt(int index) => rateModels.elementAt(index);

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
