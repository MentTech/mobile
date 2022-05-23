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