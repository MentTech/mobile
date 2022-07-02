import 'dart:developer';
import 'dart:io';

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

  Future<Map<String, dynamic>?> uploadUserAvatar({
    required String authToken,
    required File imageFile,
  }) async {
    try {
      final String fileName = imageFile.path.split('/').last;

      final FormData formData = FormData.fromMap({
        "file":
            await MultipartFile.fromFile(imageFile.path, filename: fileName),
      });

      /// post to image server
      final responseData = await _dioClient.post(
        Endpoints.imageSever,
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );

      String? uuidFileName = responseData["filename"];

      if (null != uuidFileName && uuidFileName.isNotEmpty) {
        final res = await _dioClient.patch(
          Endpoints.uploadUserAvatar,
          data: {
            "avatar": Endpoints.imageSever + "/" + uuidFileName,
          },
          options: Options(
            followRedirects: false,
            validateStatus: (status) => true,
            headers: {
              "Authorization": "Bearer $authToken",
            },
          ),
        );

        return {
          "data": res,
        };
      } else {
        return {
          "error": "Can not upload image",
        };
      }

      // return User.fromJson(res);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> updateUserInformation({
    required String authToken,
    required Map<String, String> requestBody,
  }) async {
    try {
      final res = await _dioClient.patch(
        Endpoints.updateUserInformation,
        data: requestBody,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
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

  Future<Map<String, dynamic>?> applyGiftcode({
    required String authToken,
    required Map<String, String> requestBody,
  }) async {
    try {
      final res = await _dioClient.post(
        Endpoints.applyTokenInTransaction,
        data: requestBody,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
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
