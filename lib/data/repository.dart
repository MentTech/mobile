import 'dart:async';
import 'dart:developer';

import 'package:mobile/data/network/apis/auth/auth_api.dart';
import 'package:mobile/data/network/apis/mentee/mentee_api.dart';
import 'package:mobile/data/network/apis/mentor/mentor_api.dart';
import 'package:mobile/data/sharedpref/shared_preference_helper.dart';

class Repository {
  // data source object
  // final PostDataSource _postDataSource;

  // api objects
  final AuthAPI _authApi;
  final MentorAPI _mentorAPI;
  final MenteeAPI _menteeAPI;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(
    this._authApi,
    this._mentorAPI,
    this._menteeAPI,
    this._sharedPrefsHelper,
    // this._postDataSource,
  );

  // User: ---------------------------------------------------------------------
  Future<Map<String, dynamic>?> fetchUserInfor(String authToken) async {
    return await _authApi.fetchUserInfor(
      {
        'Content-Type': 'application/json; charset=utf-8',
        "Authorization": "Bearer $authToken"
      },
    ).then((resVal) {
      return resVal;
    }).catchError((error) {
      log("Fetch Userinfor failing");
      return null;
    });
  }

  Future<Map<String, dynamic>?> fetchSessionsOfUser({
    required String authToken,
    // required Map<String, dynamic> parameters,
  }) async {
    return await _menteeAPI
        .fetchSessionsOfUser(
      authToken: authToken,
      // parameters: parameters,
    )
        .then((resVal) {
      return resVal;
    }).catchError((error) {
      log("Fetch Userinfor failing");
      return null;
    });
  }

  // Mentor: -------------------------------------------------------------------
  Future<Map<String, dynamic>?> searchMentor(
      Map<String, dynamic> parameters) async {
    return _mentorAPI
        .searchMentors(
      parameters: parameters,
    )
        .catchError((error) {
      return {
        "onError": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> fetchMentor(int mentorID) async {
    return _mentorAPI
        .fetchMentorInformation(mentorID: mentorID)
        .catchError((error) {
      return {
        "onError": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> fetchProgram(
      int mentorID, int programID) async {
    return _mentorAPI
        .fetchProgramInformation(mentorID: mentorID, programID: programID)
        .catchError((error) {
      return {
        "onError": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> fetchProgramRateList({
    required int mentorID,
    required int programID,
    required Map<String, dynamic> query,
  }) async {
    return _mentorAPI
        .fetchProgramRateList(
            mentorID: mentorID, programID: programID, query: query)
        .catchError((error) {
      return {
        "onError": "[fetchProgramRateList]: " + error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> registerProgram({
    required int mentorID,
    required int programID,
    required Map<String, dynamic> body,
  }) async {
    return _mentorAPI
        .registerProgram(
      mentorID: mentorID,
      programID: programID,
      body: body,
    )
        .catchError((error) {
      return {
        "onError": "[registerProgram]: " + error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> unregisterASessionOfProgram({
    required mentorID,
    required int programID,
    required int sessionID,
    required String authToken,
  }) async {
    return _mentorAPI
        .unregisterSession(
      mentorID: mentorID,
      programID: programID,
      sessionID: sessionID,
      authToken: authToken,
    )
        .catchError((error) {
      return {
        "onError": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> markSessionOfProgramAsDone({
    required mentorID,
    required int programID,
    required int sessionID,
    required String authToken,
  }) async {
    return _mentorAPI
        .markSessionOfProgramAsDone(
      mentorID: mentorID,
      programID: programID,
      sessionID: sessionID,
      authToken: authToken,
    )
        .catchError((error) {
      return {
        "onError": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> reviewSessionOfProgram({
    required mentorID,
    required int programID,
    required int sessionID,
    required String authToken,
    required int rate,
    required String comment,
  }) async {
    return _mentorAPI
        .reviewSessionOfProgram(
      mentorID: mentorID,
      programID: programID,
      sessionID: sessionID,
      authToken: authToken,
      rate: rate,
      comment: comment,
    )
        .catchError((error) {
      return {
        "onError": error.toString(),
      };
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

  // Authenticator:-------------------------------------------------------------
  Future<Map<String, dynamic>> register(
      String email, String password, String name) async {
    return await _authApi.register({
      "email": email,
      "password": password,
      "name": name,
    }).then((resVal) {
      return Future.value(resVal!);
    }).catchError((error) {
      return {"message": "unknown errors"};
    });
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    return await _authApi.login({
      "email": email,
      "password": password,
    }).then((resVal) {
      return Future.value(resVal!);
    }).catchError((error) {
      return {"message": "unknown errors"};
    });
  }

  Future<Map<String, dynamic>> googleAuthenticator(
      String googleAuthToken) async {
    return await _authApi.googleAuthenticator(queryParameters: {
      "token": googleAuthToken,
    }).then((resVal) {
      return Future.value(resVal!);
    }).catchError((error) {
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
