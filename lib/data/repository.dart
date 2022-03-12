import 'dart:async';
import 'dart:developer';

import 'package:mobile/constants/properties.dart';
import 'package:mobile/data/network/apis/auth/auth_api.dart';
import 'package:mobile/data/sharedpref/shared_preference_helper.dart';

class Repository {
  // data source object
  // final PostDataSource _postDataSource;

  // api objects
  final AuthAPI _authApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(
    this._authApi,
    this._sharedPrefsHelper,
    // this._postDataSource,
  );

  // Authorize: ---------------------------------------------------------------------
  Future<Map<String, dynamic>?> fetchUserInfor(String authToken) async {
    return await _authApi.fetchUserInfor(authToken).then((resVal) {
      return resVal;
    }).catchError((error) {
      log("Login Fail");
      return null;
    });
  }

  // Future<List<Post>> findPostById(int id) {
  //   //creating filter
  //   List<Filter> filters = [];

  //   //check to see if dataLogsType is not null
  //   Filter dataLogTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
  //   filters.add(dataLogTypeFilter);

  //   //making db call
  //   return _postDataSource
  //       .getAllSortedByFilter(filters: filters)
  //       .then((posts) => posts)
  //       .catchError((error) => throw error);
  // }

  // Future<int> insert(Post post) => _postDataSource
  //     .insert(post)
  //     .then((id) => id)
  //     .catchError((error) => throw error);

  // Future<int> update(Post post) => _postDataSource
  //     .update(post)
  //     .then((id) => id)
  //     .catchError((error) => throw error);

  // Future<int> delete(Post post) => _postDataSource
  //     .update(post)
  //     .then((id) => id)
  //     .catchError((error) => throw error);

  // Login:---------------------------------------------------------------------
  Future<String?> login(String email, String password) async {
    return await Future.delayed(
        const Duration(seconds: Properties.delayTimeInSecond),
        () => "askdhaksdh");
  }

  Future<Map<String, dynamic>> register(
      String email, String password, String name) async {
    return await _authApi.register({
      "email": email,
      "password": password,
      "name": name,
    }).then((resVal) {
      return Future.value(resVal!);
    }).catchError((error) {
      log("Login Fail");
      return {"message": "unknown errors"};
    });
  }

  Future<String?> get authToken => _sharedPrefsHelper.authToken;

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPrefsHelper.saveAuthToken(authToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPrefsHelper.removeAuthToken();
  }

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  String? get currentLanguage => _sharedPrefsHelper.currentLanguage;
}
