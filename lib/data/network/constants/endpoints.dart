class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://34.121.70.113/v1";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  /// AuthApi
  static const String registerUser = baseUrl + "/auth/signup";
  static const String fetchUserInfor = baseUrl + "/users/profile";
}
