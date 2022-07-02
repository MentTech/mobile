import 'package:mobile/data/repository.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/order/order.dart';
import 'package:mobile/stores/message/message_store.dart';
import 'package:mobx/mobx.dart';

part 'order_store.g.dart';

class OrderStore = _OrderStore with _$OrderStore;

abstract class _OrderStore with Store {
  // repository instance
  final Repository _repository;

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
  Order? currentOrder;

  @observable
  ObservableFuture<Map<String, dynamic>?> requestFuture = emptyResponse;

  @observable
  MessageStore messageStore = getIt<MessageStore>();

  // computed:------------------------------------------------------------------
  @computed
  bool get isLoading => requestFuture.status == FutureStatus.pending;

  @computed
  bool get isSuccess => success;

  @computed
  String get getSuccessMessageKey => messageStore.successMessagekey;

  @computed
  String get getFailedMessageKey => messageStore.errorMessagekey;

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
          // messageStore.errorMessage = e.toString();
          //     "[fetchTopupRate] error to get Topup Rate";
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
      messageStore.setErrorMessageByCode(401);
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
        if (res!["statusCode"] == null) {
          messageStore.setSuccessMessage(Code.updateUserInfor);

          currentOrder = Order.fromJson(res);

          success = true;
        } else {
          int code = res["statusCode"] as int;

          messageStore.setErrorMessageByCode(code);
        }

        success = true;
      } catch (e) {
        // res['message']
        // messageStore.errorMessage = e.toString();

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
