// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthenStore on _AuthenStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??=
          Computed<bool>(() => super.isLoading, name: '_AuthenStore.isLoading'))
      .value;
  Computed<bool>? _$canBeAuthenticatedComputed;

  @override
  bool get canBeAuthenticated => (_$canBeAuthenticatedComputed ??=
          Computed<bool>(() => super.canBeAuthenticated,
              name: '_AuthenStore.canBeAuthenticated'))
      .value;
  Computed<String>? _$getSuccessMessageKeyComputed;

  @override
  String get getSuccessMessageKey => (_$getSuccessMessageKeyComputed ??=
          Computed<String>(() => super.getSuccessMessageKey,
              name: '_AuthenStore.getSuccessMessageKey'))
      .value;
  Computed<String>? _$getFailedMessageKeyComputed;

  @override
  String get getFailedMessageKey => (_$getFailedMessageKeyComputed ??=
          Computed<String>(() => super.getFailedMessageKey,
              name: '_AuthenStore.getFailedMessageKey'))
      .value;
  Computed<bool>? _$isSuccessComputed;

  @override
  bool get isSuccess => (_$isSuccessComputed ??=
          Computed<bool>(() => super.isSuccess, name: '_AuthenStore.isSuccess'))
      .value;

  late final _$accessTokenAtom =
      Atom(name: '_AuthenStore.accessToken', context: context);

  @override
  String? get accessToken {
    _$accessTokenAtom.reportRead();
    return super.accessToken;
  }

  @override
  set accessToken(String? value) {
    _$accessTokenAtom.reportWrite(value, super.accessToken, () {
      super.accessToken = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_AuthenStore.success', context: context);

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

  late final _$messageStoreAtom =
      Atom(name: '_AuthenStore.messageStore', context: context);

  @override
  MessageStore get messageStore {
    _$messageStoreAtom.reportRead();
    return super.messageStore;
  }

  @override
  set messageStore(MessageStore value) {
    _$messageStoreAtom.reportWrite(value, super.messageStore, () {
      super.messageStore = value;
    });
  }

  late final _$credentialFutureAtom =
      Atom(name: '_AuthenStore.credentialFuture', context: context);

  @override
  ObservableFuture<Map<String, dynamic>> get credentialFuture {
    _$credentialFutureAtom.reportRead();
    return super.credentialFuture;
  }

  @override
  set credentialFuture(ObservableFuture<Map<String, dynamic>> value) {
    _$credentialFutureAtom.reportWrite(value, super.credentialFuture, () {
      super.credentialFuture = value;
    });
  }

  late final _$registerAsyncAction =
      AsyncAction('_AuthenStore.register', context: context);

  @override
  Future<String?> register(String email, String password, String name) {
    return _$registerAsyncAction
        .run(() => super.register(email, password, name));
  }

  late final _$loginAsyncAction =
      AsyncAction('_AuthenStore.login', context: context);

  @override
  Future<void> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  late final _$googleAuthenticatorAsyncAction =
      AsyncAction('_AuthenStore.googleAuthenticator', context: context);

  @override
  Future<String?> googleAuthenticator() {
    return _$googleAuthenticatorAsyncAction
        .run(() => super.googleAuthenticator());
  }

  late final _$changePasswordAsyncAction =
      AsyncAction('_AuthenStore.changePassword', context: context);

  @override
  Future<String?> changePassword(String oldPassword, String newPassword) {
    return _$changePasswordAsyncAction
        .run(() => super.changePassword(oldPassword, newPassword));
  }

  @override
  String toString() {
    return '''
accessToken: ${accessToken},
success: ${success},
messageStore: ${messageStore},
credentialFuture: ${credentialFuture},
isLoading: ${isLoading},
canBeAuthenticated: ${canBeAuthenticated},
getSuccessMessageKey: ${getSuccessMessageKey},
getFailedMessageKey: ${getFailedMessageKey},
isSuccess: ${isSuccess}
    ''';
  }
}
