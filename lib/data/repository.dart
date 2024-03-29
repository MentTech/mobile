import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:mobile/data/network/apis/auth/auth_api.dart';
import 'package:mobile/data/network/apis/chat/chat_api.dart';
import 'package:mobile/data/network/apis/common/common_api.dart';
import 'package:mobile/data/network/apis/mentee/mentee_api.dart';
import 'package:mobile/data/network/apis/mentor/mentor_api.dart';
import 'package:mobile/data/network/apis/notification/notification_api.dart';
import 'package:mobile/data/network/apis/transaction/transaction_api.dart';
import 'package:mobile/data/sharedpref/shared_preference_helper.dart';

class Repository {
  // data source object
  // final PostDataSource _postDataSource;

  // api objects
  final AuthAPI _authApi;
  final MentorAPI _mentorAPI;
  final MenteeAPI _menteeAPI;
  final CommonAPI _commonAPI;
  final TransactionAPI _transactionAPI;
  final NotifitcationAPI _notifitcationAPI;
  final ChatAPI _chatAPI;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(
    this._authApi,
    this._mentorAPI,
    this._menteeAPI,
    this._commonAPI,
    this._transactionAPI,
    this._notifitcationAPI,
    this._chatAPI,
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
    Map<String, dynamic>? parameters,
  }) async {
    return await _menteeAPI
        .fetchSessionsOfUser(
      authToken: authToken,
      parameters: parameters ?? {},
    )
        .then((resVal) {
      return resVal;
    }).catchError((error) {
      log("Fetch Userinfor failing");
      return null;
    });
  }

  Future<Map<String, dynamic>?> fetchSession({
    required String authToken,
    required int sessionId,
  }) async {
    return await _menteeAPI
        .fetchOnlySession(
      authToken: authToken,
      sessionId: sessionId,
    )
        .then((resVal) {
      return resVal;
    }).catchError((error) {
      log("Fetch Userinfor failing");
      return null;
    });
  }

  Future<Map<String, dynamic>?> uploadUserAvatar({
    required String authToken,
    required File image,
  }) async {
    return _menteeAPI
        .uploadUserAvatar(
      authToken: authToken,
      imageFile: image,
    )
        .catchError((error) {
      return {
        "statusCode": 417,
        "message": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> updateUserInformation({
    required String authToken,
    required Map<String, String> data,
  }) async {
    return _menteeAPI
        .updateUserInformation(
      authToken: authToken,
      requestBody: data,
    )
        .catchError((error) {
      return {
        "statusCode": 417,
        "message": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> applyGiftcode({
    required String authToken,
    required Map<String, String> data,
  }) async {
    return _menteeAPI
        .applyGiftcode(
      authToken: authToken,
      requestBody: data,
    )
        .catchError((error) {
      return {
        "statusCode": 417,
        "message": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> fetchFavouriteMentors(
      {required String authToken}) async {
    return _menteeAPI
        .fetchFavouriteMentors(authToken: authToken)
        .catchError((error) {
      return {
        "statusCode": 417,
        "message": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> addFavouriteMentor(
      {required String authToken, required int mentorId}) async {
    return _menteeAPI
        .addFavouriteMentor(authToken: authToken, mentorId: mentorId)
        .catchError((error) {
      return {
        "statusCode": 417,
        "message": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> removeFavouriteMentor(
      {required String authToken, required int mentorId}) async {
    return _menteeAPI
        .removeFavouriteMentor(authToken: authToken, mentorId: mentorId)
        .catchError((error) {
      return {
        "statusCode": 417,
        "message": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>> changePassword({
    required String authToken,
    required Map<String, dynamic> body,
  }) async {
    return await _authApi
        .changePassword(authToken: authToken, body: body)
        .then((resVal) {
      return resVal!;
    }).catchError((error) {
      log("Fetch Userinfor failing");
      return {"error": "Fetch fail"};
    });
  }

  // Notification notification: ------------------------------------------------
  Future<Map<String, dynamic>?> fetchAllNotifications({
    required String authToken,
    required Map<String, dynamic> params,
  }) async {
    return _notifitcationAPI
        .fetchAllNotifications(authToken: authToken, params: params)
        .catchError((error) {
      return {
        "statusCode": 500,
        "message": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> markMultiNotificationsAsRead({
    required String authToken,
    required List<int> markReadedIds,
  }) async {
    return _notifitcationAPI.markMultiNotificationsAsRead(
      authToken: authToken,
      body: {
        "ids": markReadedIds,
      },
    ).catchError((error) {
      return {
        "statusCode": 500,
        "message": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> markNotificationAsRead({
    required String authToken,
    required int notificationId,
  }) async {
    return _notifitcationAPI
        .markNotificationAsRead(
            authToken: authToken, notificationId: notificationId)
        .catchError((error) {
      return {
        "statusCode": 500,
        "message": error.toString(),
      };
    });
  }

  // Chat Api: -----------------------------------------------------------------
  Future<Map<String, dynamic>?> getChatRoomInformation({
    required String authToken,
    required int sessionId,
  }) async {
    return _chatAPI
        .getChatRoomInformation(authToken: authToken, sessionId: sessionId)
        .catchError((error) {
      return {
        "statusCode": 500,
        "message": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> getAllRooms({
    required String authToken,
  }) async {
    return _chatAPI.getAllRooms(authToken: authToken).catchError((error) {
      return {
        "statusCode": 500,
        "message": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> getRoomInformation({
    required String authToken,
    required int roomId,
  }) async {
    return _chatAPI
        .getRoomInformation(authToken: authToken, roomId: roomId)
        .catchError((error) {
      return {
        "statusCode": 500,
        "message": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> sendMessage({
    required String authToken,
    required int roomId,
    required String message,
  }) async {
    return _chatAPI
        .sendMessage(authToken: authToken, roomId: roomId, message: message)
        .catchError((error) {
      return {
        "statusCode": 500,
        "message": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> getAllMessages({
    required String authToken,
    required int roomId,
    required Map<String, int> parameters,
  }) async {
    return _chatAPI
        .getAllMessages(
            authToken: authToken, roomId: roomId, parameters: parameters)
        .catchError((error) {
      return {
        "statusCode": 500,
        "message": error.toString(),
      };
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
        "statusCode": 417,
        "message": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> fetchMentor(int mentorID) async {
    return _mentorAPI
        .fetchMentorInformation(mentorID: mentorID)
        .catchError((error) {
      return {
        "statusCode": 417,
        "message": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> fetchRecommendedMentors() async {
    return _mentorAPI.fetchRecommendedMentors().catchError(
      (error) {
        log("message [fetchRecommendedMentors] " + error.toString());
        return {
          "statusCode": 417,
          "message": error.toString(),
        };
      },
    );
  }

  Future<Map<String, dynamic>?> fetchMultipleMentorsByIds({
    required String authToken,
    required List<int> ids,
  }) async {
    return _mentorAPI
        .fetchMultipleMentorsByIds(
      authToken: authToken,
      ids: ids,
    )
        .catchError((error) {
      return {
        "statusCode": 417,
        "message": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> fetchProgram(
      int mentorID, int programID) async {
    return _mentorAPI
        .fetchProgramInformation(mentorID: mentorID, programID: programID)
        .catchError((error) {
      return {
        "statusCode": 417,
        "message": error.toString(),
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
    required String authToken,
    required int mentorID,
    required int programID,
    required Map<String, dynamic> body,
  }) async {
    return _mentorAPI
        .registerProgram(
      authToken: authToken,
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
        "statusCode": 417,
        "message": error.toString(),
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
        "statusCode": 417,
        "message": error.toString(),
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
        "statusCode": 417,
        "message": error.toString(),
      };
    });
  }

  // CommonAPI:-----------------------------------------------------------------

  Future<Map<String, dynamic>?> fetchAllSkills() async {
    return _commonAPI.fetchAllSkills().catchError((error) {
      return {
        "statusCode": 417,
        "message": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> fetchAllCategories() async {
    return _commonAPI.fetchAllCategories().catchError((error) {
      return {
        "statusCode": 417,
        "message": error.toString(),
      };
    });
  }

  // Transaction:---------------------------------------------------------------
  Future<Map<String, dynamic>?> fetchTransactions({
    required String authToken,
  }) async {
    return _transactionAPI
        .fetchTransactions(
      authToken: authToken,
    )
        .catchError((error) {
      return {
        "statusCode": 417,
        "message": error.toString(),
      };
    });
  }

  // Order:---------------------------------------------------------------------
  Future<Map<String, dynamic>?> fetchTopupRate() async {
    return _transactionAPI.fetchTopupRate().catchError((error) {
      return {
        "statusCode": 417,
        "message": error.toString(),
      };
    });
  }

  Future<Map<String, dynamic>?> createTopupOrder({
    required String authToken,
    required Map<String, dynamic> orderInfor,
  }) async {
    return _transactionAPI
        .createTopupOrder(authToken: authToken, orderInfor: orderInfor)
        .catchError((error) {
      return {
        "statusCode": 417,
        "message": error.toString(),
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

  Future<String?> get userEmailAccount => _sharedPrefsHelper.userEmailAccount;

  Future<bool> saveUserEmailAccount(String userEmailAccount) async {
    return _sharedPrefsHelper.saveUserEmailAccount(userEmailAccount);
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
