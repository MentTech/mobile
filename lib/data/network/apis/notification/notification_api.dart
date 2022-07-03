import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mobile/data/network/constants/endpoints.dart';
import 'package:mobile/data/network/dio_client.dart';

class NotifitcationAPI {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  // final RestClient _restClient;

  // injecting dio instance
  NotifitcationAPI(
    this._dioClient,
    // this._restClient,
  );

  Future<Map<String, dynamic>?> fetchAllNotifications({
    required String authToken,
    required Map<String, dynamic> params,
  }) async {
    try {
      final res = await _dioClient.get(
        Endpoints.fetchAllNotifications,
        queryParameters: params,
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

  Future<Map<String, dynamic>?> markMultiNotificationsAsRead({
    required String authToken,
    required Map<String, List<int>> body,
  }) async {
    try {
      final res = await _dioClient.patch(
        Endpoints.markMultiNotificationsAsRead,
        data: body,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
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

  Future<Map<String, dynamic>?> markNotificationAsRead({
    required String authToken,
    required int notificationId,
  }) async {
    try {
      final res = await _dioClient.patch(
        Endpoints.markNotificationAsRead
            .replaceAll(":notificationId", notificationId.toString()),
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
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
