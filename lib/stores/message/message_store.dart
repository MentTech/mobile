import 'dart:developer';

import 'package:mobx/mobx.dart';

part 'message_store.g.dart';

class MessageStore = _MessageStore with _$MessageStore;

abstract class _MessageStore with Store {
  // disposers
  late List<ReactionDisposer> _disposers;

  // constructor:---------------------------------------------------------------
  _MessageStore() {
    _disposers = [
      reaction((_) => errorMessage, reset, delay: 200),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String errorMessage = '';

  @observable
  String successMessage = '';

  @observable
  bool expriredToken = false;

  // actions:-------------------------------------------------------------------
  @action
  void setErrorMessage(String message) {
    errorMessage = message;
  }

  @action
  void setSuccessMessage(String message) {
    successMessage = message;
  }

  @action
  void reset(String value) {
    log('calling reset');
    errorMessage = '';
    successMessage = '';
  }

  @action
  void notifyExpiredTokenStatus() {
    expriredToken = true;
  }

  // dispose:-------------------------------------------------------------------
  @action
  dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
