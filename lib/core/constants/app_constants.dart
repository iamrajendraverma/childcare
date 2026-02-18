// API Constants
class ApiConstants {
  static const String baseUrl = 'http://192.168.29.25:5001';
  static const String signIn = '/api/signin';
  static const String signUp = '/api/signup';
  
  // Complete URLs
  static String get signInUrl => '$baseUrl$signIn';
  static String get signUpUrl => '$baseUrl$signUp';
}

// Storage Keys
class StorageKeys {
  static const String authToken = 'auth_token';
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';
  static const String userName = 'user_name';
}
