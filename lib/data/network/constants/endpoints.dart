class Endpoints {
  Endpoints._();

  /// api for: api data, socketio
  static const String apiUrl = "https://api.menttech.live";

  /// base url
  static const String baseUrl = apiUrl + "/v1";

  /// base url
  static const String imageSever = "https://images.menttech.live";

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

  /// Change password
  static const String changePassword = _authProxy + "/changepassword";

  /// Google Token: /auth/google/token
  static const String googleAuth = _authProxy + "/google/token";

  //:---------------------------------------------------------------------------

  /// User APIs
  /// Private User proxy
  static const String _userProxy = baseUrl + "/users";

  /// Get User Infor: /users/profile
  static const String fetchUserInfor = _userProxy + "/profile";

  /// Patch User Infor for building: /users/profile
  static const String updateUserInformation = _userProxy + "/profile";

  /// Patch User Avatar for building: /users/avatar
  static const String uploadUserAvatar = _userProxy + "/avatar";

  //:---------------------------------------------------------------------------

  /// Mentor APIs
  /// Private Mentor proxy
  static const String _mentorProxy = baseUrl + "/mentor";

  /// Get List (paginate) of mentor information: /mentor/search
  static const String searchMentorPagination = _mentorProxy + "/search";

  /// Get List (paginate) of mentor information: /mentor/suggest
  static const String fetchRecommendedMentors = _mentorProxy + "/suggest";

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

  /// UnRegister a mentor's session
  static const String unregisterProgram =
      _mentorProxy + "/:mentorId/program/:programId/register/:sessionId";

  /// Mark a mentor's session as done
  static const String markAsDoneSessionProgram =
      _mentorProxy + "/:mentorId/program/:programId/register/:sessionId/done";

  /// Review a mentor's session
  static const String reviewSessionProgram =
      _mentorProxy + "/:mentorId/program/:programId/register/:sessionId/rating";

  /// Fetch multiple mentors
  static const String fetchMultipleMentors = _mentorProxy + "/multiple";

  //:---------------------------------------------------------------------------

  /// Mentee APIs
  /// Private Mentee proxy
  static const String _menteeProxy = baseUrl + "/mentee";

  /// Get all sessions which are registered by user
  static const String sessionRegisterProgram = _menteeProxy + "/mysession";

  /// Get one session which is registered by user
  static const String sessionRegistered =
      _menteeProxy + "/mysession/:sessionId";

  /// Fetch favourite mentor List: /mentee/favorite
  static const String fetchFavouriteMentors = _menteeProxy + "/favorite";

  /// Add a favorite mentor to server /mentee/favorite
  static const String addNewFavouriteMentor = _menteeProxy + "/favorite";

  /// Remove a favorite mentor in server mentee/favorite/:mentorId
  static const String deleteFavouriteMentor =
      _menteeProxy + "/favorite/:mentorId";

  //:---------------------------------------------------------------------------

  /// Common APIs

  /// Get all skills in Server
  static const String fetchAllSkill = baseUrl + "/skill";

  /// Get all categories in Server
  static const String fetchAllCategory = baseUrl + "/category";

  //:---------------------------------------------------------------------------

  /// Transaction APIS
  ///

  /// Get all transaction in Server
  static const String fetchUserTransactions = baseUrl + "/transaction/balance";

  /// Get all transaction in Server
  static const String applyTokenInTransaction =
      baseUrl + "/transaction/card/apply";

  //:---------------------------------------------------------------------------

  /// Order APIS
  ///

  /// Private Order proxy
  static const String _orderProxy = baseUrl + "/order";

  /// Get rate of Topup per currency
  static const String fetchTopupRatePerCurrency = _orderProxy + "/rate/top-up";

  /// Create a Topup Order
  static const String createTopupOrder = _orderProxy + "/top-up";

  //:---------------------------------------------------------------------------

  ///
  /// Notification Apis
  ///

  /// Get all notifications
  static const String fetchAllNotifications = baseUrl + "/notification";

  /// Mark multiple notifications as read
  static const String markMultiNotificationsAsRead =
      baseUrl + "/notification/multiple";

  /// Mark a notification as read
  static const String markNotificationAsRead =
      baseUrl + "/notification/:notificationId";

  //:---------------------------------------------------------------------------

  ///
  /// Chat Apis
  ///

  ///
  /// Chat proxy
  ///
  static const String _chatProxy = "/chat";

  /// Get chat room information
  static const String getChatRoomInformation =
      _chatProxy + "/session/:sessionId";

  /// Get all rooms
  static const String getAllRooms = _chatProxy + "/room";

  /// Get room information
  static const String getRoomInformation = _chatProxy + "/room/:roomId";

  /// Send message to that room
  static const String sendMessageToRoom = _chatProxy + "/room/:roomId";

  /// Get all message of that room
  static const String getAllMessageOfRoom =
      _chatProxy + "/room/:roomId/message";

  //:---------------------------------------------------------------------------
}
