// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MessageStore on _MessageStore, Store {
  late final _$errorMessagekeyAtom =
      Atom(name: '_MessageStore.errorMessagekey', context: context);

  @override
  String get errorMessagekey {
    _$errorMessagekeyAtom.reportRead();
    return super.errorMessagekey;
  }

  @override
  set errorMessagekey(String value) {
    _$errorMessagekeyAtom.reportWrite(value, super.errorMessagekey, () {
      super.errorMessagekey = value;
    });
  }

  late final _$successMessagekeyAtom =
      Atom(name: '_MessageStore.successMessagekey', context: context);

  @override
  String get successMessagekey {
    _$successMessagekeyAtom.reportRead();
    return super.successMessagekey;
  }

  @override
  set successMessagekey(String value) {
    _$successMessagekeyAtom.reportWrite(value, super.successMessagekey, () {
      super.successMessagekey = value;
    });
  }

  late final _$expriredTokenAtom =
      Atom(name: '_MessageStore.expriredToken', context: context);

  @override
  bool get expriredToken {
    _$expriredTokenAtom.reportRead();
    return super.expriredToken;
  }

  @override
  set expriredToken(bool value) {
    _$expriredTokenAtom.reportWrite(value, super.expriredToken, () {
      super.expriredToken = value;
    });
  }

  late final _$_MessageStoreActionController =
      ActionController(name: '_MessageStore', context: context);

  @override
  void setErrorMessage(String message) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.setErrorMessage');
    try {
      return super.setErrorMessage(message);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setErrorMessageByCode(int code) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.setErrorMessageByCode');
    try {
      return super.setErrorMessageByCode(code);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSuccessMessage(Code code) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.setSuccessMessage');
    try {
      return super.setSuccessMessage(code);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetError(String value) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.resetError');
    try {
      return super.resetError(value);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetSuccess(String value) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.resetSuccess');
    try {
      return super.resetSuccess(value);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void notifyExpiredTokenStatus() {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.notifyExpiredTokenStatus');
    try {
      return super.notifyExpiredTokenStatus();
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic dispose() {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.dispose');
    try {
      return super.dispose();
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorMessagekey: ${errorMessagekey},
successMessagekey: ${successMessagekey},
expriredToken: ${expriredToken}
    ''';
  }
}
