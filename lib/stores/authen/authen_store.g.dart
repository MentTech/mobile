// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

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

  late final _$loginFutureAtom =
      Atom(name: '_AuthenStore.loginFuture', context: context);

  @override
  ObservableFuture<Map<String, dynamic>> get loginFuture {
    _$loginFutureAtom.reportRead();
    return super.loginFuture;
  }

  @override
  set loginFuture(ObservableFuture<Map<String, dynamic>> value) {
    _$loginFutureAtom.reportWrite(value, super.loginFuture, () {
      super.loginFuture = value;
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
  Future<String?> login(String email, String password) {
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
loginFuture: ${loginFuture},
isLoading: ${isLoading},
canBeAuthenticated: ${canBeAuthenticated}
    ''';
  }
}
