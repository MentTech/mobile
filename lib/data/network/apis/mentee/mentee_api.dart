import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mobile/data/network/constants/endpoints.dart';
import 'package:mobile/data/network/dio_client.dart';

class MenteeAPI {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  // final RestClient _restClient;

  // injecting dio instance
  MenteeAPI(
    this._dioClient,
    // this._restClient,
  );

  Future<Map<String, dynamic>?> fetchSessionsOfUser({
    required String authToken,
    // required Map<String, dynamic> parameters,
  }) async {
    try {
      final res = await _dioClient.get(
        Endpoints.sessionRegisterProgram,
        // queryParameters: parameters,
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

      return {
        "sessions": res,
      };
      // return User.fromJson(res);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> fetchFavouriteMentors(
      {required String authToken}) async {
    try {
      final res = await _dioClient.get(
        Endpoints.fetchFavouriteMentors,
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
        "ids": res,
      };
      // return User.fromJson(res);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> addFavouriteMentor(
      {required String authToken, required int mentorId}) async {
    try {
      final res = await _dioClient.post(
        Endpoints.addNewFavouriteMentor,
        data: {
          "mentorId": mentorId,
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

  Future<Map<String, dynamic>?> removeFavouriteMentor(
      {required String authToken, required int mentorId}) async {
    try {
      final res = await _dioClient.delete(
        Endpoints.deleteFavouriteMentor.replaceAll(":mentorId", "$mentorId"),
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
}
