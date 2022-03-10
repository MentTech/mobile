class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://localhost:8000";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  /// AuthApi
  static const String fetchUserInfor = baseUrl + "/v1/users/profile";
}
