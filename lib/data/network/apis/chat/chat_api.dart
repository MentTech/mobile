import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mobile/data/network/constants/endpoints.dart';
import 'package:mobile/data/network/dio_client.dart';

class ChatAPI {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  // final RestClient _restClient;

  // injecting dio instance
  ChatAPI(
    this._dioClient,
    // this._restClient,
  );

  Future<Map<String, dynamic>?> getChatRoomInformation({
    required String authToken,
    required int sessionId,
  }) async {
    try {
      final res = await _dioClient.get(
        Endpoints.getChatRoomInformation
            .replaceAll(":sessionId", sessionId.toString()),
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

      // if (res is List) {
      //   return {
      //     "data": res,
      //   };
      // } else {
      //   return res;
      // }
      return res;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getAllRooms({
    required String authToken,
  }) async {
    try {
      final res = await _dioClient.get(
        Endpoints.getAllRooms,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            "Authorization": "Bearer $authToken"
          },
        ),
      );

      // if (res is List) {
      //   return {
      //     "data": res,
      //   };
      // } else {
      //   return res;
      // }
      return res;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getRoomInformation({
    required String authToken,
    required int roomId,
  }) async {
    try {
      final res = await _dioClient.get(
        Endpoints.getRoomInformation.replaceAll(":roomId", roomId.toString()),
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            "Authorization": "Bearer $authToken"
          },
        ),
      );

      // if (res is List) {
      //   return {
      //     "data": res,
      //   };
      // } else {
      //   return res;
      // }
      return res;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> sendMessage({
    required String authToken,
    required int roomId,
    required String message,
  }) async {
    try {
      final res = await _dioClient.post(
        Endpoints.sendMessageToRoom.replaceAll(":roomId", roomId.toString()),
        data: {
          "message": message,
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

      // if (res is List) {
      //   return {
      //     "data": res,
      //   };
      // } else {
      //   return res;
      // }
      return res;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getAllMessages({
    required String authToken,
    required int roomId,
    required Map<String, int> parameters,
  }) async {
    try {
      final res = await _dioClient.get(
        Endpoints.sendMessageToRoom.replaceAll(":roomId", roomId.toString()),
        queryParameters: parameters,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            "Authorization": "Bearer $authToken"
          },
        ),
      );

      if (res is List) {
        return {
          "data": res,
        };
      } else {
        return res;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
