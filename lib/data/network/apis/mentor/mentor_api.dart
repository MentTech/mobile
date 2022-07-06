import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mobile/data/network/constants/endpoints.dart';
import 'package:mobile/data/network/dio_client.dart';

class MentorAPI {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  // final RestClient _restClient;

  // injecting dio instance
  MentorAPI(
    this._dioClient,
    // this._restClient,
  );

  Future<Map<String, dynamic>?> searchMentors(
      {required Map<String, dynamic> parameters}) async {
    try {
      final res = await _dioClient.get(
        Endpoints.searchMentorPagination,
        queryParameters: parameters,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          // headers: headers
          // headers: {
          //   'Content-Type': 'application/json; charset=utf-8',
          //   "Authorization": "Bearer $authToken"
          // },
        ),
      );

      return res;
      // return User.fromJson(res);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> fetchRecommendedMentors() async {
    try {
      final res = await _dioClient.get(
        Endpoints.fetchRecommendedMentors,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );

      return {
        "data": res,
      };
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> fetchMultipleMentorsByIds({
    required String authToken,
    required List<int> ids,
  }) async {
    try {
      final res = await _dioClient.get(
        Endpoints.fetchMultipleMentors,
        queryParameters: {
          "ids": ids,
        },
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            "Authorization": "Bearer $authToken"
          },
        ),
      );

      return {
        "data": res,
      };
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> fetchMentorInformation(
      {required int mentorID}) async {
    try {
      final res = await _dioClient.get(
        Endpoints.fetchMentorInfor.replaceAll(":id", "$mentorID"),
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          // headers: headers
          // headers: {
          //   'Content-Type': 'application/json; charset=utf-8',
          //   "Authorization": "Bearer $authToken"
          // },
        ),
      );

      return res;
      // return User.fromJson(res);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> fetchProgramInformation(
      {required int mentorID, required int programID}) async {
    try {
      final res = await _dioClient.get(
        Endpoints.fetchProgramInfor
            .replaceAll(":id", "$mentorID")
            .replaceAll(":programid", "$programID"),
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          // headers: headers
          // headers: {
          //   'Content-Type': 'application/json; charset=utf-8',
          //   "Authorization": "Bearer $authToken"
          // },
        ),
      );

      return res;
      // return User.fromJson(res);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> fetchProgramRateList({
    required int mentorID,
    required int programID,
    required Map<String, dynamic> query,
  }) async {
    try {
      final res = await _dioClient.get(
        Endpoints.fetchProgramRateList
            .replaceAll(":mentorId", "$mentorID")
            .replaceAll(":id", "$programID"),
        queryParameters: query,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );

      return res;
      // return User.fromJson(res);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> registerProgram({
    required String authToken,
    required int mentorID,
    required int programID,
    required Map<String, dynamic> body,
  }) async {
    try {
      final res = await _dioClient.post(
        Endpoints.registerProgram
            .replaceAll(":mentorId", "$mentorID")
            .replaceAll(":id", "$programID"),
        data: body,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          // headers: headers
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            "Authorization": "Bearer $authToken"
          },
        ),
      );

      return res;
      // return User.fromJson(res);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> unregisterSession({
    required mentorID,
    required int programID,
    required int sessionID,
    required String authToken,
  }) async {
    try {
      final res = await _dioClient.delete(
        Endpoints.unregisterProgram
            .replaceAll(":mentorId", "$mentorID")
            .replaceAll(":programId", "$programID")
            .replaceAll(":sessionId", "$sessionID"),
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          // headers: headers
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            "Authorization": "Bearer $authToken"
          },
        ),
      );

      return res;
      // return User.fromJson(res);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> markSessionOfProgramAsDone({
    required mentorID,
    required int programID,
    required int sessionID,
    required String authToken,
  }) async {
    try {
      final res = await _dioClient.patch(
        Endpoints.markAsDoneSessionProgram
            .replaceAll(":mentorId", "$mentorID")
            .replaceAll(":programId", "$programID")
            .replaceAll(":sessionId", "$sessionID"),
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          // headers: headers
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            "Authorization": "Bearer $authToken"
          },
        ),
      );

      return res;
      // return User.fromJson(res);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> reviewSessionOfProgram({
    required mentorID,
    required int programID,
    required int sessionID,
    required String authToken,
    required int rate,
    required String comment,
  }) async {
    try {
      final res = await _dioClient.post(
        Endpoints.reviewSessionProgram
            .replaceAll(":mentorId", "$mentorID")
            .replaceAll(":programId", "$programID")
            .replaceAll(":sessionId", "$sessionID"),
        data: {
          "rating": rate,
          "comment": comment,
        },
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          // headers: headers
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            "Authorization": "Bearer $authToken"
          },
        ),
      );

      return res;
      // return User.fromJson(res);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // /// Returns list of post in response
  // Future<PostList> getPosts() async {
  //   try {
  //     final res = await _dioClient.get(Endpoints.getPosts);
  //     return PostList.fromJson(res);
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  /// sample api call with default rest client
//  Future<PostsList> getPosts() {
//
//    return _restClient
//        .get(Endpoints.getPosts)
//        .then((dynamic res) => PostsList.fromJson(res))
//        .catchError((error) => throw NetworkException(message: error));
//  }

}
