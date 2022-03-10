import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mobile/data/network/constants/endpoints.dart';
import 'package:mobile/data/network/dio_client.dart';

class AuthAPI {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  // final RestClient _restClient;

  // injecting dio instance
  AuthAPI(
    this._dioClient,
    // this._restClient,
  );

  Future<Map<String, dynamic>?> fetchUserInfor(String authToken) async {
    try {
      final res = await _dioClient.get(
        Endpoints.fetchUserInfor,
        // options: Options(
        //   followRedirects: false,
        //   validateStatus: (status) => true,
        //   headers: {
        //     'Content-Type': 'application/json; charset=utf-8',
        //     "Authorization": "Bearer $authToken"
        //   },
        // )
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
