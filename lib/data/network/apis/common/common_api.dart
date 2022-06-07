import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mobile/data/network/constants/endpoints.dart';
import 'package:mobile/data/network/dio_client.dart';

class CommonAPI {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  CommonAPI(
    this._dioClient,
  );

  Future<Map<String, dynamic>?> fetchAllSkills() async {
    try {
      final res = await _dioClient.get(
        Endpoints.fetchAllSkill,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );

      return {
        "skills": res,
      };
      // return User.fromJson(res);
    } catch (e) {
      log("?>" + e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> fetchAllCategories() async {
    try {
      final res = await _dioClient.get(
        Endpoints.fetchAllCategory,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );

      return {
        "categories": res,
      };
      // return User.fromJson(res);
    } catch (e) {
      log("?>" + e.toString());
      rethrow;
    }
  }
}
