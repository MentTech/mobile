// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authen_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthenticatorFormStore on _AuthenticatorFormStore, Store {
  Computed<bool>? _$canLoginComputed;

  @override
  bool get canLogin =>
      (_$canLoginComputed ??= Computed<bool>(() => super.canLogin,
              name: '_AuthenticatorFormStore.canLogin'))
          .value;
  Computed<bool>? _$canRegisterComputed;

  @override
  bool get canRegister =>
      (_$canRegisterComputed ??= Computed<bool>(() => super.canRegister,
              name: '_AuthenticatorFormStore.canRegister'))
          .value;
  Computed<bool>? _$canForgetPasswordComputed;

  @override
  bool get canForgetPassword => (_$canForgetPasswordComputed ??= Computed<bool>(
          () => super.canForgetPassword,
          name: '_AuthenticatorFormStore.canForgetPassword'))
      .value;
  Computed<bool>? _$canChangePasswordComputed;

  @override
  bool get canChangePassword => (_$canChangePasswordComputed ??= Computed<bool>(
          () => super.canChangePassword,
          name: '_AuthenticatorFormStore.canChangePassword'))
      .value;

  late final _$stateAuthenAtom =
      Atom(name: '_AuthenticatorFormStore.stateAuthen', context: context);

  @override
  AuthenState get stateAuthen {
    _$stateAuthenAtom.reportRead();
    return super.stateAuthen;
  }

  @override
  set stateAuthen(AuthenState value) {
    _$stateAuthenAtom.reportWrite(value, super.stateAuthen, () {
      super.stateAuthen = value;
    });
  }

  late final _$isForgotPasswordStateAtom = Atom(
      name: '_AuthenticatorFormStore.isForgotPasswordState', context: context);

  @override
  bool get isForgotPasswordState {
    _$isForgotPasswordStateAtom.reportRead();
    return super.isForgotPasswordState;
  }

  @override
  set isForgotPasswordState(bool value) {
    _$isForgotPasswordStateAtom.reportWrite(value, super.isForgotPasswordState,
        () {
      super.isForgotPasswordState = value;
    });
  }

  late final _$userEmailAtom =
      Atom(name: '_AuthenticatorFormStore.userEmail', context: context);

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  late final _$oldPasswordAtom =
      Atom(name: '_AuthenticatorFormStore.oldPassword', context: context);

  @override
  String get oldPassword {
    _$oldPasswordAtom.reportRead();
    return super.oldPassword;
  }

  @override
  set oldPassword(String value) {
    _$oldPasswordAtom.reportWrite(value, super.oldPassword, () {
      super.oldPassword = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_AuthenticatorFormStore.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$confirmPasswordAtom =
      Atom(name: '_AuthenticatorFormStore.confirmPassword', context: context);

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  late final _$nameAtom =
      Atom(name: '_AuthenticatorFormStore.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_AuthenticatorFormStore.success', context: context);

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

  late final _$loginedAtom =
      Atom(name: '_AuthenticatorFormStore.logined', context: context);

  @override
  bool get logined {
    _$loginedAtom.reportRead();
    return super.logined;
  }

  @override
  set logined(bool value) {
    _$loginedAtom.reportWrite(value, super.logined, () {
      super.logined = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_AuthenticatorFormStore.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$_AuthenticatorFormStoreActionController =
      ActionController(name: '_AuthenticatorFormStore', context: context);

  @override
  void setUserId(String value) {
    final _$actionInfo = _$_AuthenticatorFormStoreActionController.startAction(
        name: '_AuthenticatorFormStore.setUserId');
    try {
      return super.setUserId(value);
    } finally {
      _$_AuthenticatorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOldPassword(String value) {
    final _$actionInfo = _$_AuthenticatorFormStoreActionController.startAction(
        name: '_AuthenticatorFormStore.setOldPassword');
    try {
      return super.setOldPassword(value);
    } finally {
      _$_AuthenticatorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_AuthenticatorFormStoreActionController.startAction(
        name: '_AuthenticatorFormStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_AuthenticatorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String value) {
    final _$actionInfo = _$_AuthenticatorFormStoreActionController.startAction(
        name: '_AuthenticatorFormStore.setConfirmPassword');
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$_AuthenticatorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String value) {
    final _$actionInfo = _$_AuthenticatorFormStoreActionController.startAction(
        name: '_AuthenticatorFormStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_AuthenticatorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSignup() {
    final _$actionInfo = _$_AuthenticatorFormStoreActionController.startAction(
        name: '_AuthenticatorFormStore.setSignup');
    try {
      return super.setSignup();
    } finally {
      _$_AuthenticatorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSignin() {
    final _$actionInfo = _$_AuthenticatorFormStoreActionController.startAction(
        name: '_AuthenticatorFormStore.setSignin');
    try {
      return super.setSignin();
    } finally {
      _$_AuthenticatorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setForgotPassword() {
    final _$actionInfo = _$_AuthenticatorFormStoreActionController.startAction(
        name: '_AuthenticatorFormStore.setForgotPassword');
    try {
      return super.setForgotPassword();
    } finally {
      _$_AuthenticatorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUserEmail(String value) {
    final _$actionInfo = _$_AuthenticatorFormStoreActionController.startAction(
        name: '_AuthenticatorFormStore.validateUserEmail');
    try {
      return super.validateUserEmail(value);
    } finally {
      _$_AuthenticatorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateOldPassword(String value) {
    final _$actionInfo = _$_AuthenticatorFormStoreActionController.startAction(
        name: '_AuthenticatorFormStore.validateOldPassword');
    try {
      return super.validateOldPassword(value);
    } finally {
      _$_AuthenticatorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$_AuthenticatorFormStoreActionController.startAction(
        name: '_AuthenticatorFormStore.validatePassword');
    try {
      return super.validatePassword(value);
    } finally {
      _$_AuthenticatorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateConfirmPassword(String value) {
    final _$actionInfo = _$_AuthenticatorFormStoreActionController.startAction(
        name: '_AuthenticatorFormStore.validateConfirmPassword');
    try {
      return super.validateConfirmPassword(value);
    } finally {
      _$_AuthenticatorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateName(String value) {
    final _$actionInfo = _$_AuthenticatorFormStoreActionController.startAction(
        name: '_AuthenticatorFormStore.validateName');
    try {
      return super.validateName(value);
    } finally {
      _$_AuthenticatorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
stateAuthen: ${stateAuthen},
isForgotPasswordState: ${isForgotPasswordState},
userEmail: ${userEmail},
oldPassword: ${oldPassword},
password: ${password},
confirmPassword: ${confirmPassword},
name: ${name},
success: ${success},
logined: ${logined},
loading: ${loading},
canLogin: ${canLogin},
canRegister: ${canRegister},
canForgetPassword: ${canForgetPassword},
canChangePassword: ${canChangePassword}
    ''';
  }
}

mixin _$FormErrorStore on _FormErrorStore, Store {
  Computed<bool>? _$hasErrorsInLoginComputed;

  @override
  bool get hasErrorsInLogin => (_$hasErrorsInLoginComputed ??= Computed<bool>(
          () => super.hasErrorsInLogin,
          name: '_FormErrorStore.hasErrorsInLogin'))
      .value;
  Computed<bool>? _$hasErrorsInRegisterComputed;

  @override
  bool get hasErrorsInRegister => (_$hasErrorsInRegisterComputed ??=
          Computed<bool>(() => super.hasErrorsInRegister,
              name: '_FormErrorStore.hasErrorsInRegister'))
      .value;
  Computed<bool>? _$hasErrorInForgotPasswordComputed;

  @override
  bool get hasErrorInForgotPassword => (_$hasErrorInForgotPasswordComputed ??=
          Computed<bool>(() => super.hasErrorInForgotPassword,
              name: '_FormErrorStore.hasErrorInForgotPassword'))
      .value;
  Computed<bool>? _$hasErrorInRenewPasswordComputed;

  @override
  bool get hasErrorInRenewPassword => (_$hasErrorInRenewPasswordComputed ??=
          Computed<bool>(() => super.hasErrorInRenewPassword,
              name: '_FormErrorStore.hasErrorInRenewPassword'))
      .value;

  late final _$oldPasswordAtom =
      Atom(name: '_FormErrorStore.oldPassword', context: context);

  @override
  String? get oldPassword {
    _$oldPasswordAtom.reportRead();
    return super.oldPassword;
  }

  @override
  set oldPassword(String? value) {
    _$oldPasswordAtom.reportWrite(value, super.oldPassword, () {
      super.oldPassword = value;
    });
  }

  late final _$userEmailAtom =
      Atom(name: '_FormErrorStore.userEmail', context: context);

  @override
  String? get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String? value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_FormErrorStore.password', context: context);

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$confirmPasswordAtom =
      Atom(name: '_FormErrorStore.confirmPassword', context: context);

  @override
  String? get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String? value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  late final _$nameAtom = Atom(name: '_FormErrorStore.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  @override
  String toString() {
    return '''
oldPassword: ${oldPassword},
userEmail: ${userEmail},
password: ${password},
confirmPassword: ${confirmPassword},
name: ${name},
hasErrorsInLogin: ${hasErrorsInLogin},
hasErrorsInRegister: ${hasErrorsInRegister},
hasErrorInForgotPassword: ${hasErrorInForgotPassword},
hasErrorInRenewPassword: ${hasErrorInRenewPassword}
    ''';
  }
}
