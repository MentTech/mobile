import 'package:mobx/mobx.dart';

part 'message_store.g.dart';

class MessageStore = _MessageStore with _$MessageStore;

abstract class _MessageStore with Store {
  // disposers
  late List<ReactionDisposer> _disposers;

  // constructor:---------------------------------------------------------------
  _MessageStore() {
    _disposers = [
      reaction((_) => errorMessagekey, resetError, delay: 200),
      reaction((_) => successMessagekey, resetSuccess, delay: 200),
    ];
  }

  // attributes:----------------------------------------------------------------
  final ResponseCode _responseCodeInstance = ResponseCode();

  // store variables:-----------------------------------------------------------
  @observable
  String errorMessagekey = '';

  @observable
  String successMessagekey = '';

  @observable
  bool expriredToken = false;

  // actions:-------------------------------------------------------------------
  @action
  void setErrorMessage(String message) {
    errorMessagekey = message;
  }

  @action
  void setErrorMessageByCode(int code) {
    errorMessagekey = _responseCodeInstance.toErrorMessageKey(code);
  }

  @action
  void setSuccessMessage(Code code) {
    successMessagekey = _responseCodeInstance.toSuccessMessageKey(code);
  }

  @action
  void resetError(String value) {
    errorMessagekey = '';
  }

  @action
  void resetSuccess(String value) {
    successMessagekey = '';
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

//------------------------------------------------------------------------------
enum Code {
  authenticated,
  updateUserInfor,
  createTopup,
  changePassword,
  applyGiftcode,
  updateSession,
  getChatRoom,
  getRoomContent,
}

class ResponseCode {
  final Map<int, String> responseCode = <int, String>{
    401: "unauthorized_key_translate",
    402: "unauthorized_wrong_credential_key_translate",
    // 403: "session_already_done",
    403: "not_activated_account",
    404: "gift_code_not_found_translate",
    405: "wrong_current_password_translate",
    407: "proxy_authentication_required",
    422: "already_registered_program",
    500: "internal_eerver_error",
  };

  final Map<Code, String> successCode = <Code, String>{
    Code.authenticated: "authorized_key_translate",
    Code.updateUserInfor: "update_user_profile_title_success",
    Code.changePassword: "change_password_success",
    Code.applyGiftcode: "apply_giftcode_success",
    Code.updateSession: "update_session_success",
    Code.getChatRoom: "get_chat_room_success",
    Code.getRoomContent: "get_room_content_success",
    Code.createTopup: "create_topup_request_success",
  };

  bool _authenticated = false;

  void setAuthenticated() {
    _authenticated = true;
  }

  bool get isAuthen => _authenticated;

  ResponseCode();

  String toErrorMessageKey(int code) {
    if (401 == code) {
      _authenticated = false;
    }
    return responseCode[code]!;
  }

  String toSuccessMessageKey(Code code) {
    return successCode[code]!;
  }
}
