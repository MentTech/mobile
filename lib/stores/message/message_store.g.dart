// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MessageStore on _MessageStore, Store {
  final _$errorMessageAtom = Atom(name: '_MessageStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$successMessageAtom = Atom(name: '_MessageStore.successMessage');

  @override
  String get successMessage {
    _$successMessageAtom.reportRead();
    return super.successMessage;
  }

  @override
  set successMessage(String value) {
    _$successMessageAtom.reportWrite(value, super.successMessage, () {
      super.successMessage = value;
    });
  }

  final _$_MessageStoreActionController =
      ActionController(name: '_MessageStore');

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
  void setSuccessMessage(String message) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.setSuccessMessage');
    try {
      return super.setSuccessMessage(message);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset(String value) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.reset');
    try {
      return super.reset(value);
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
errorMessage: ${errorMessage},
successMessage: ${successMessage}
    ''';
  }
}