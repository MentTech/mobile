import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile/data/repository.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/message/message_store.dart';
import 'package:mobx/mobx.dart';

part 'authen_store.g.dart';

class AuthenStore = _AuthenStore with _$AuthenStore;

abstract class _AuthenStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling error messages
  final MessageStore messageStore = getIt<MessageStore>();

  // constructor:---------------------------------------------------------------
  _AuthenStore(Repository repository) : _repository = repository {
    // setting up disposers
    _setupDisposers();

    // checking if user is logged in
    repository.authToken.then((value) {
      accessToken = value;
    });

    repository.userEmailAccount.then((value) {
      _userAccountEmail = value;
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

  // general variables:---------------------------------------------------------
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/userinfo.email',
  ]);

  // store variables:-----------------------------------------------------------
  String? _userAccountEmail;

  // token for access
  @observable
  String? accessToken;

  @observable
  bool success = false;

  @observable
  ObservableFuture<Map<String, dynamic>> credentialFuture = emptyLoginResponse;

  @computed
  bool get isLoading => credentialFuture.status == FutureStatus.pending;

  @computed
  bool get canBeAuthenticated => accessToken != null;

  @computed
  String get getSuccessMessageKey => messageStore.successMessagekey;

  @computed
  String get getFailedMessageKey => messageStore.errorMessagekey;

  @computed
  bool get isSuccess => success;

  // actions:-------------------------------------------------------------------
  @action
  Future<String?> register(String email, String password, String name) async {
    final future = _repository.register(email, password, name);

    credentialFuture = ObservableFuture(future);

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
  Future<void> login(String email, String password) async {
    final future = _repository.login(email, password);

    credentialFuture = ObservableFuture(future);
    success = false;

    await future.then((mapJson) async {
      if (mapJson["statusCode"] == null) {
        final token = mapJson["accessToken"];
        await _repository.saveAuthToken(token);
        accessToken = token;

        messageStore.setSuccessMessage(Code.authenticated);

        _repository.saveUserEmailAccount(email);

        success = true;
      } else {
        int code = mapJson["statusCode"] as int;
        if (401 == code) {
          code++;
        }
        messageStore.setErrorMessageByCode(code);
      }
    }).catchError((e) {
      log(e.toString());
      accessToken = null;
      throw e;
    });
  }

  @action
  Future<String?> googleAuthenticator() async {
    String? message;
    success = false;
    accessToken = null;
    message = "Can't login by Google account";

    try {
      await logoutGoogleAuth().then((_) async {
        await googleSignIn.signIn().then((account) async {
          await account?.authentication.then((credential) async {
            final token = credential.accessToken;
            if (token != null) {
              await _repository
                  .googleAuthenticator(token)
                  .then((mapJson) async {
                if (mapJson["message"] == null) {
                  success = true;

                  accessToken = mapJson["accessToken"];
                  await _repository.saveAuthToken(accessToken!);
                }

                message = mapJson['message'];
              }).catchError((e) {
                log(e.toString());
                accessToken = null;
                success = false;
                throw e;
              });
            } else {
              throw StateError("Fail to authenticate by Google");
            }
          });
        });
      });
    } on PlatformException {
      throw "PlatformException";
      // Handle err
    } catch (err) {
      // other types of Exceptions
      throw "other types of Exceptions";
    }

    return Future.value(message);
  }

  Future<void> logout() async {
    await logoutGoogleAuth();

    accessToken = null;
    _repository.removeAuthToken();
  }

  Future<void> logoutGoogleAuth() async {
    try {
      if (googleSignIn.currentUser != null) {
        await googleSignIn.disconnect();
      }
    } on PlatformException {
      throw "PlatformException";
      // Handle err
    } catch (err) {
      // other types of Exceptions
      throw "other types of Exceptions";
    }
  }

  @action
  Future<void> changePassword(String oldPassword, String newPassword) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      success = false;

      "No access token";
      return;
    }

    final future = _repository.changePassword(
      authToken: accessToken,
      body: {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      },
    );

    credentialFuture = ObservableFuture(future);

    await future.then((mapJson) async {
      if (mapJson["statusCode"] == null) {
        messageStore.setSuccessMessage(Code.changePassword);

        success = true;
      } else {
        int code = mapJson["statusCode"] as int;

        messageStore.setErrorMessageByCode(code);
      }
    }).catchError((e) {
      log(e.toString());
      accessToken = null;
      success = false;
      throw e;
    });
  }

  // getter:--------------------------------------------------------------------
  bool get isLoggedIn => accessToken != null;

  String? get userEmailAccount {
    return _userAccountEmail;
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
