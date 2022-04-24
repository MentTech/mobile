class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://api.menttech.live/v1";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  //:---------------------------------------------------------------------------

  /// Authentication APIs
  /// Private Authentication proxy
  static const String _authProxy = baseUrl + "/auth";

  /// Register User: /auth/signup
  static const String registerUser = _authProxy + "/signup";

  /// Login User: /auth/signin
  static const String loginUser = _authProxy + "/signin";

  /// Google Token: /auth/google/token
  static const String googleAuth = _authProxy + "/google/token";

  //:---------------------------------------------------------------------------

  /// User APIs
  /// Private User proxy
  static const String _userProxy = baseUrl + "/users";

  /// Get User Infor: /users/profile
  static const String fetchUserInfor = _userProxy + "/profile";

  //:---------------------------------------------------------------------------

  /// Mentor APIs
  /// Private Mentor proxy
  static const String _mentorProxy = baseUrl + "/mentor";

  /// Get List (paginate) of mentor information: /users/profile
  static const String searchMentorPagination = _mentorProxy + "/search";

  //:---------------------------------------------------------------------------

}
