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
      reaction((_) => oldPassword, validateOldPassword),
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
  String oldPassword = '';

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

  @computed
  bool get canChangePassword =>
      !formErrorStore.hasErrorInRenewPassword &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      oldPassword.isNotEmpty;

  // @computed
  // FormStatus get renewPasswordStatus {
  //   if (password.isEmpty || confirmPassword.isEmpty || newPassword.isEmpty) {
  //     return FormStatus.missingField;
  //   }
  //   if (confirmPassword.compareTo(password) != 0) {
  //     return FormStatus.notMatchPassword;
  //   }
  //   return FormStatus.allValidated; // canChangePassword
  // }

  // actions:-------------------------------------------------------------------
  @action
  void setUserId(String value) {
    userEmail = value;
  }

  @action
  void setOldPassword(String value) {
    oldPassword = value;
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
  void validateOldPassword(String value) {
    if (value.isEmpty) {
      formErrorStore.oldPassword = "Password can't be empty";
    } else if (value.length < 6) {
      formErrorStore.oldPassword =
          "Password must be at-least 6 characters long";
    } else {
      formErrorStore.oldPassword = null;
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

  void validatePasswordChanger() {
    validateOldPassword(oldPassword);
    validatePassword(password);
    validateConfirmPassword(confirmPassword);
  }
}

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  @observable
  String? oldPassword;

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

  @computed
  bool get hasErrorInRenewPassword =>
      password != null || confirmPassword != null || oldPassword != null;
}
