class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://34.121.70.113/v1";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  /// AuthApi
  /// Register User: /auth/signup
  static const String registerUser = baseUrl + "/auth/signup";

  /// Login User: /auth/signin
  static const String loginUser = baseUrl + "/auth/signin";

  /// Google Token: /auth/google/token
  static const String googleAuth = baseUrl + "/auth/google/token";

  /// Get User Infor: /users/profile
  static const String fetchUserInfor = baseUrl + "/users/profile";
}
