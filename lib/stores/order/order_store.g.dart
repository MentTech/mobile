// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderStore on _OrderStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??=
          Computed<bool>(() => super.isLoading, name: '_OrderStore.isLoading'))
      .value;
  Computed<bool>? _$isSuccessComputed;

  @override
  bool get isSuccess => (_$isSuccessComputed ??=
          Computed<bool>(() => super.isSuccess, name: '_OrderStore.isSuccess'))
      .value;
  Computed<String>? _$getSuccessMessageKeyComputed;

  @override
  String get getSuccessMessageKey => (_$getSuccessMessageKeyComputed ??=
          Computed<String>(() => super.getSuccessMessageKey,
              name: '_OrderStore.getSuccessMessageKey'))
      .value;
  Computed<String>? _$getFailedMessageKeyComputed;

  @override
  String get getFailedMessageKey => (_$getFailedMessageKeyComputed ??=
          Computed<String>(() => super.getFailedMessageKey,
              name: '_OrderStore.getFailedMessageKey'))
      .value;

  late final _$successAtom =
      Atom(name: '_OrderStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$rateTopupAtom =
      Atom(name: '_OrderStore.rateTopup', context: context);

  @override
  int get rateTopup {
    _$rateTopupAtom.reportRead();
    return super.rateTopup;
  }

  @override
  set rateTopup(int value) {
    _$rateTopupAtom.reportWrite(value, super.rateTopup, () {
      super.rateTopup = value;
    });
  }

  late final _$currentOrderAtom =
      Atom(name: '_OrderStore.currentOrder', context: context);

  @override
  Order? get currentOrder {
    _$currentOrderAtom.reportRead();
    return super.currentOrder;
  }

  @override
  set currentOrder(Order? value) {
    _$currentOrderAtom.reportWrite(value, super.currentOrder, () {
      super.currentOrder = value;
    });
  }

  late final _$requestFutureAtom =
      Atom(name: '_OrderStore.requestFuture', context: context);

  @override
  ObservableFuture<Map<String, dynamic>?> get requestFuture {
    _$requestFutureAtom.reportRead();
    return super.requestFuture;
  }

  @override
  set requestFuture(ObservableFuture<Map<String, dynamic>?> value) {
    _$requestFutureAtom.reportWrite(value, super.requestFuture, () {
      super.requestFuture = value;
    });
  }

  late final _$fetchTopupRateAsyncAction =
      AsyncAction('_OrderStore.fetchTopupRate', context: context);

  @override
  Future<dynamic> fetchTopupRate() {
    return _$fetchTopupRateAsyncAction.run(() => super.fetchTopupRate());
  }

  late final _$orderATopupAsyncAction =
      AsyncAction('_OrderStore.orderATopup', context: context);

  @override
  Future<void> orderATopup({required Map<String, dynamic> orderInfor}) {
    return _$orderATopupAsyncAction
        .run(() => super.orderATopup(orderInfor: orderInfor));
  }

  @override
  String toString() {
    return '''
success: ${success},
rateTopup: ${rateTopup},
currentOrder: ${currentOrder},
requestFuture: ${requestFuture},
isLoading: ${isLoading},
isSuccess: ${isSuccess},
getSuccessMessageKey: ${getSuccessMessageKey},
getFailedMessageKey: ${getFailedMessageKey}
    ''';
  }
}
