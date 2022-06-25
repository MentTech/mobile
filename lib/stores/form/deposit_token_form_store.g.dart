// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_token_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DepositTokenFormStore on _DepositTokenFormStore, Store {
  Computed<bool>? _$canLoadTokenComputed;

  @override
  bool get canLoadToken =>
      (_$canLoadTokenComputed ??= Computed<bool>(() => super.canLoadToken,
              name: '_DepositTokenFormStore.canLoadToken'))
          .value;

  late final _$nameAtom =
      Atom(name: '_DepositTokenFormStore.name', context: context);

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

  late final _$emailAtom =
      Atom(name: '_DepositTokenFormStore.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$tokenAtom =
      Atom(name: '_DepositTokenFormStore.token', context: context);

  @override
  String get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  late final _$noteAtom =
      Atom(name: '_DepositTokenFormStore.note', context: context);

  @override
  String get note {
    _$noteAtom.reportRead();
    return super.note;
  }

  @override
  set note(String value) {
    _$noteAtom.reportWrite(value, super.note, () {
      super.note = value;
    });
  }

  late final _$paymentMethodAtom =
      Atom(name: '_DepositTokenFormStore.paymentMethod', context: context);

  @override
  PaymentMethod get paymentMethod {
    _$paymentMethodAtom.reportRead();
    return super.paymentMethod;
  }

  @override
  set paymentMethod(PaymentMethod value) {
    _$paymentMethodAtom.reportWrite(value, super.paymentMethod, () {
      super.paymentMethod = value;
    });
  }

  late final _$_DepositTokenFormStoreActionController =
      ActionController(name: '_DepositTokenFormStore', context: context);

  @override
  void setName(String value) {
    final _$actionInfo = _$_DepositTokenFormStoreActionController.startAction(
        name: '_DepositTokenFormStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_DepositTokenFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_DepositTokenFormStoreActionController.startAction(
        name: '_DepositTokenFormStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_DepositTokenFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setToken(String value) {
    final _$actionInfo = _$_DepositTokenFormStoreActionController.startAction(
        name: '_DepositTokenFormStore.setToken');
    try {
      return super.setToken(value);
    } finally {
      _$_DepositTokenFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNote(String value) {
    final _$actionInfo = _$_DepositTokenFormStoreActionController.startAction(
        name: '_DepositTokenFormStore.setNote');
    try {
      return super.setNote(value);
    } finally {
      _$_DepositTokenFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPaymentMethod(PaymentMethod paymentMethod) {
    final _$actionInfo = _$_DepositTokenFormStoreActionController.startAction(
        name: '_DepositTokenFormStore.setPaymentMethod');
    try {
      return super.setPaymentMethod(paymentMethod);
    } finally {
      _$_DepositTokenFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateName(String value) {
    final _$actionInfo = _$_DepositTokenFormStoreActionController.startAction(
        name: '_DepositTokenFormStore.validateName');
    try {
      return super.validateName(value);
    } finally {
      _$_DepositTokenFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateEmail(String value) {
    final _$actionInfo = _$_DepositTokenFormStoreActionController.startAction(
        name: '_DepositTokenFormStore.validateEmail');
    try {
      return super.validateEmail(value);
    } finally {
      _$_DepositTokenFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateToken(String value) {
    final _$actionInfo = _$_DepositTokenFormStoreActionController.startAction(
        name: '_DepositTokenFormStore.validateToken');
    try {
      return super.validateToken(value);
    } finally {
      _$_DepositTokenFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateNote(String value) {
    final _$actionInfo = _$_DepositTokenFormStoreActionController.startAction(
        name: '_DepositTokenFormStore.validateNote');
    try {
      return super.validateNote(value);
    } finally {
      _$_DepositTokenFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
email: ${email},
token: ${token},
note: ${note},
paymentMethod: ${paymentMethod},
canLoadToken: ${canLoadToken}
    ''';
  }
}

mixin _$ProgramRegisterErrorForm on _ProgramRegisterErrorForm, Store {
  Computed<bool>? _$hasErrorsLoadComputed;

  @override
  bool get hasErrorsLoad =>
      (_$hasErrorsLoadComputed ??= Computed<bool>(() => super.hasErrorsLoad,
              name: '_ProgramRegisterErrorForm.hasErrorsLoad'))
          .value;

  late final _$nameAtom =
      Atom(name: '_ProgramRegisterErrorForm.name', context: context);

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

  late final _$emailAtom =
      Atom(name: '_ProgramRegisterErrorForm.email', context: context);

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$tokenAtom =
      Atom(name: '_ProgramRegisterErrorForm.token', context: context);

  @override
  String? get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String? value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  late final _$noteAtom =
      Atom(name: '_ProgramRegisterErrorForm.note', context: context);

  @override
  String? get note {
    _$noteAtom.reportRead();
    return super.note;
  }

  @override
  set note(String? value) {
    _$noteAtom.reportWrite(value, super.note, () {
      super.note = value;
    });
  }

  @override
  String toString() {
    return '''
name: ${name},
email: ${email},
token: ${token},
note: ${note},
hasErrorsLoad: ${hasErrorsLoad}
    ''';
  }
}
