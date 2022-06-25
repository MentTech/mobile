import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mobile/data/network/constants/endpoints.dart';
import 'package:mobile/data/network/dio_client.dart';

class TransactionAPI {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  // final RestClient _restClient;

  // injecting dio instance
  TransactionAPI(
    this._dioClient,
    // this._restClient,
  );

  Future<Map<String, dynamic>?> fetchTransactions(
      {required String authToken}) async {
    try {
      final res = await _dioClient.get(
        Endpoints.fetchUserTransactions,
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

  Future<Map<String, dynamic>?> fetchTopupRate() async {
    try {
      final res = await _dioClient.get(
        Endpoints.fetchTopupRatePerCurrency,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );

      return res;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> createTopupOrder({
    required String authToken,
    required Map<String, dynamic> orderInfor,
  }) async {
    try {
      final res = await _dioClient.post(
        Endpoints.createTopupOrder,
        data: orderInfor,
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
}
