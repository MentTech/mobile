import 'dart:developer';

import 'package:mobile/data/repository.dart';
import 'package:mobx/mobx.dart';

part 'authen_store.g.dart';

class AuthenStore = _AuthenStore with _$AuthenStore;

abstract class _AuthenStore with Store {
  // repository instance
  final Repository _repository;

  // constructor:---------------------------------------------------------------
  _AuthenStore(Repository repository) : _repository = repository {
    // setting up disposers
    _setupDisposers();

    // checking if user is logged in
    repository.authToken.then((value) {
      accessToken = value;
    });
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<Map<String, dynamic>> emptyLoginResponse =
      ObservableFuture.value({});

  // store variables:-----------------------------------------------------------

  // token for access
  @observable
  String? accessToken;

  @observable
  bool success = false;

  @observable
  ObservableFuture<Map<String, dynamic>> loginFuture = emptyLoginResponse;

  @computed
  bool get isLoading => loginFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future<String?> register(String email, String password, String name) async {
    final future = _repository.register(email, password, name);

    loginFuture = ObservableFuture(future);

    String? message;

    await future.then((mapJson) async {
      if (mapJson["message"] == null) {
        success = true;
      }

      message = mapJson['message'];
    }).catchError((e) {
      log(e.toString());
      accessToken = null;
      success = false;
      throw e;
    });

    return Future.value(message);
  }

  @action
  Future<String?> login(String email, String password) async {
    final future = _repository.login(email, password);

    loginFuture = ObservableFuture(future);

    String? message;

    await future.then((mapJson) async {
      if (mapJson["message"] == null) {
        success = true;

        final token = mapJson["accessToken"];
        _repository.saveAuthToken(token);
        accessToken = token;
      }

      message = mapJson['message'];
    }).catchError((e) {
      log(e.toString());
      accessToken = null;
      success = false;
      throw e;
    });

    return Future.value(message);
  }

  logout() {
    accessToken = null;
    _repository.removeAuthToken();
  }

  // getter:--------------------------------------------------------------------
  bool get isLoggedIn => accessToken != null;

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
