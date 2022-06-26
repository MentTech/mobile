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

  // attributes:----------------------------------------------------------------
  final ResponseCode _responseCodeInstance = ResponseCode();

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
  void setErrorMessageByCode(int code) {
    errorMessage = _responseCodeInstance.notifyMessage(code);
  }

  @action
  void setSuccessMessage(String message) {
    successMessage = message;
  }

  @action
  void reset(String value) {
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

class ResponseCode {
  final Map<int, String> responseCode = <int, String>{};

  bool _authenticated = false;

  set setAuthenticate(bool authenticated) {
    _authenticated = authenticated;
  }

  bool get isAuthen => _authenticated;

  ResponseCode();

  String notifyMessage(int code) {
    // if some code is unauthen = > set unauthen = true
    return responseCode[code]! + "_translate";
  }
}
