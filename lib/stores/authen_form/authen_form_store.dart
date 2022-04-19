import 'dart:developer';

import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/authen/authen_store.dart';
import 'package:mobile/stores/message/message_store.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'authen_form_store.g.dart';

enum AuthenState {
  signin,
  signup,
}

class AuthenticatorFormStore = _AuthenticatorFormStore
    with _$AuthenticatorFormStore;

abstract class _AuthenticatorFormStore with Store {
  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  final MessageStore messageStore = MessageStore();

  // store for handling authenticators
  final AuthenStore authenStore = getIt<AuthenStore>();

  _AuthenticatorFormStore() {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => userEmail, validateUserEmail),
      reaction((_) => password, validatePassword),
      reaction((_) => confirmPassword, validateConfirmPassword),
      reaction((_) => name, validateName),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  AuthenState stateAuthen = AuthenState.signin;

  @observable
  bool isForgotPasswordState = false;

  @observable
  String userEmail = '';

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @observable
  String name = '';

  @observable
  bool success = false;

  @observable
  bool logined = false;

  @observable
  bool loading = false;

  @computed
  bool get canLogin =>
      !formErrorStore.hasErrorsInLogin &&
      userEmail.isNotEmpty &&
      password.isNotEmpty;

  @computed
  bool get canRegister =>
      !formErrorStore.hasErrorsInRegister &&
      userEmail.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      name.isNotEmpty;

  @computed
  bool get canForgetPassword =>
      !formErrorStore.hasErrorInForgotPassword && userEmail.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setUserId(String value) {
    userEmail = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  @action
  void setName(String value) {
    name = value;
  }

  @action
  void setSignup() {
    stateAuthen = AuthenState.signup;
    isForgotPasswordState = false;
  }

  @action
  void setSignin() {
    stateAuthen = AuthenState.signin;
    isForgotPasswordState = false;
  }

  @action
  void setForgotPassword() {
    stateAuthen = AuthenState.signin;
    isForgotPasswordState = true;
  }

  @action
  void validateUserEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.userEmail = "Email can't be empty";
    } else if (!isEmail(value)) {
      formErrorStore.userEmail = 'Please enter a valid email address';
    } else {
      formErrorStore.userEmail = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      formErrorStore.password = "Password can't be empty";
    } else if (value.length < 6) {
      formErrorStore.password = "Password must be at-least 6 characters long";
    } else {
      formErrorStore.password = null;
    }
  }

  @action
  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      formErrorStore.confirmPassword = "Confirm password can't be empty";
    } else if (value != password) {
      formErrorStore.confirmPassword = "Password doen't match";
    } else {
      formErrorStore.confirmPassword = null;
    }
  }

  @action
  void validateName(String value) {
    if (value.isEmpty) {
      formErrorStore.name = "Confirm name can't be empty";
    } else {
      formErrorStore.confirmPassword = null;
    }
  }

  @action
  Future register() async {
    loading = true;

    authenStore.register(userEmail, password, name).then((future) {
      loading = false;

      if (future != null) {
        messageStore.errorMessage = future;
        success = false;
      } else {
        messageStore.successMessage =
            "Your account has been created successfully";
        success = true;
      }
    }).catchError((e) {
      loading = false;
      success = false;
      messageStore.errorMessage = e.toString().contains("ERROR_USER_NOT_FOUND")
          ? "Username and password doesn't match"
          : "Something went wrong, please check your internet connection and try again";
      log(e.toString());
    });
  }

  @action
  Future login() async {
    loading = true;
    success = false;
    messageStore.successMessage = "You have not logined yet";

    authenStore.login(userEmail, password).then((future) {
      loading = false;

      if (future != null) {
        messageStore.errorMessage = future;
        success = false;
      } else {
        messageStore.successMessage = "You are login successfully";
        success = true;
        logined = true;
      }
    }).catchError((e) {
      loading = false;
      success = false;
      messageStore.errorMessage = e.toString().contains("ERROR_USER_NOT_FOUND")
          ? "Username and password doesn't match"
          : "Something went wrong, please check your internet connection and try again";
      log(e.toString());
    });
  }

  @action
  Future<bool> googleAuthenticator() async {
    loading = true;
    success = false;

    try {
      await authenStore.googleAuthenticator().then((result) {
        loading = false;

        if (result == null) {
          success = true;
          logined = true;
          messageStore.successMessage = "You are login successfully";
          return Future.value(true);
        } else {
          success = false;
          logined = false;
          messageStore.errorMessage = "You has not authenticated yet";
          return Future.value(false);
        }
      });
    } catch (err) {
      // other types of Exceptions
      messageStore.errorMessage = err.toString();
      success = false;
    }

    return Future.value(false);
  }

  @action
  Future forgotPassword() async {
    loading = true;
  }

  @action
  Future logout() async {
    loading = true;
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validatePassword(password);
    validateUserEmail(userEmail);
    validateConfirmPassword(confirmPassword);
    validateName(name);
  }
}

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  @observable
  String? userEmail;

  @observable
  String? password;

  @observable
  String? confirmPassword;

  @observable
  String? name;

  @computed
  bool get hasErrorsInLogin => userEmail != null || password != null;

  @computed
  bool get hasErrorsInRegister =>
      userEmail != null ||
      password != null ||
      confirmPassword != null ||
      name != null;

  @computed
  bool get hasErrorInForgotPassword => userEmail != null;
}
