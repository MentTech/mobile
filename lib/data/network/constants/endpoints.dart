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

  /// Get specificed mentor information: /mentor/:id
  static const String fetchMentorInfor = _mentorProxy + "/:id";

  /// Get specificed program information: /mentor/:id/program/:programid
  static const String fetchProgramInfor =
      _mentorProxy + "/:id/program/:programid";

  /// Get all rates of a mentor's program
  static const String fetchProgramRateList =
      _mentorProxy + "/:mentorId/program/:id/rating";

  /// Register a mentor's program
  static const String registerProgram =
      _mentorProxy + "/:mentorId/program/:id/register";

  //:---------------------------------------------------------------------------

}
