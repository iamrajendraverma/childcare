// API Constants
class ApiConstants {
  static const String baseUrl = 'http://192.168.29.118:5002';
  static const String signIn = '/api/signin';
  static const String signUp = '/api/signup';
  static const String upload = '/childcare/api/upload';
  static const String cryAnalysis = '/childcare/api/cry-analysis';
  
  // Complete URLs
  static String get signInUrl => '$baseUrl$signIn';
  static String get signUpUrl => '$baseUrl$signUp';
  static String get uploadUrl => '$baseUrl$upload';
  static String get cryAnalysisUrl => '$baseUrl$cryAnalysis';
}

// Storage Keys
class StorageKeys {
  static const String authToken = 'auth_token';
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';
  static const String userName = 'user_name';
}
