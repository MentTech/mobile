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

  final _$accessTokenAtom = Atom(name: '_AuthenStore.accessToken');

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

  final _$successAtom = Atom(name: '_AuthenStore.success');

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

  final _$loginFutureAtom = Atom(name: '_AuthenStore.loginFuture');

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

  final _$registerAsyncAction = AsyncAction('_AuthenStore.register');

  @override
  Future<String?> register(String email, String password, String name) {
    return _$registerAsyncAction
        .run(() => super.register(email, password, name));
  }

  final _$loginAsyncAction = AsyncAction('_AuthenStore.login');

  @override
  Future<bool> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  @override
  String toString() {
    return '''
accessToken: ${accessToken},
success: ${success},
loginFuture: ${loginFuture},
isLoading: ${isLoading}
    ''';
  }
}
