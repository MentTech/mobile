import 'dart:developer';

import 'package:mobile/data/repository.dart';
import 'package:mobile/stores/message/message_store.dart';
import 'package:mobx/mobx.dart';

part 'order_store.g.dart';

class OrderStore = _OrderStore with _$OrderStore;

abstract class _OrderStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling error messages
  final MessageStore messageStore = MessageStore();

  // constructor:---------------------------------------------------------------
  _OrderStore(Repository repository) : _repository = repository {
    // setting up disposers
    _setupDisposers();

    fetchTopupRate();
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

  // observable variables:------------------------------------------------------
  @observable
  bool success = false;

  @observable
  int rateTopup = 0;

  @observable
  ObservableFuture<Map<String, dynamic>?> requestFuture = emptyResponse;

  // computed:------------------------------------------------------------------
  @computed
  bool get isLoading => requestFuture.status == FutureStatus.pending;

  @computed
  bool get isSuccess => success;

  // actions:-------------------------------------------------------------------
  @action
  Future fetchTopupRate() async {
    final future = _repository.fetchTopupRate();

    await future.then(
      (res) {
        try {
          String? topUpRate = res!["topUpRate"];
          if (null != topUpRate && topUpRate.isNotEmpty) {
            rateTopup = int.parse(topUpRate);
          }
        } catch (e) {
          // res['message']
          messageStore.errorMessage = e.toString();
          messageStore.successMessage =
              "[fetchTopupRate] error to get Topup Rate";
        }
      },
    );
    // await compute(fetchTopupRateLoop, true);
  }

  // Future fetchTopupRateLoop(bool isRetry) async {
  //   success = false;

  //   // first try =, if success => it ok
  //   final future = _repository.fetchTopupRate();

  //   await future.then(
  //     (res) {
  //       try {
  //         String? topUpRate = res!["topUpRate"];
  //         if (null != topUpRate && topUpRate.isNotEmpty) {
  //           success = true;
  //         }
  //       } catch (e) {
  //         // res['message']
  //         messageStore.errorMessage = e.toString();
  //         messageStore.successMessage =
  //             "[fetchTopupRate] error to get Topup Rate";
  //       }
  //     },
  //   );

  //   // retry if retry == true and not success in previous step
  //   while (isRetry && !success) {
  //     final future = _repository.fetchTopupRate();

  //     await future.then(
  //       (res) {
  //         try {
  //           String? topUpRate = res!["topUpRate"];
  //           if (null != topUpRate && topUpRate.isNotEmpty) {
  //             success = true;
  //           }
  //         } catch (e) {
  //           // res['message']
  //           messageStore.errorMessage = e.toString();
  //           messageStore.successMessage =
  //               "[fetchTopupRate] error to get Topup Rate";
  //         }
  //       },
  //     );
  //   }
  // }

  @action
  Future<void> orderATopup({required Map<String, dynamic> orderInfor}) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.successMessage = "";
      messageStore.errorMessage = "There are no AccessToken";
      messageStore.notifyExpiredTokenStatus();

      success = false;

      return;
    }

    final future = _repository.createTopupOrder(
      authToken: accessToken,
      orderInfor: orderInfor,
    );
    requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        // rateModels = ObservableList.of(RateModelList.fromJson(res!).rateModels);
        final String? orderID = res!["orderId"];
        if (null != orderID && orderID.isNotEmpty) {
          messageStore.successMessage =
              "You create a request load tokens successfully.";
        } else {
          messageStore.errorMessage = "Your request has been failed.";
        }

        success = true;
      } catch (e) {
        // res['message']
        messageStore.errorMessage = e.toString();

        success = false;
      }
    });
  }

  // general methods:-----------------------------------------------------------

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
