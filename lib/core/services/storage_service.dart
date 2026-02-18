import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save auth token
  Future<bool> saveAuthToken(String token) async {
    return await _prefs?.setString(StorageKeys.authToken, token) ?? false;
  }

  // Get auth token
  String? getAuthToken() {
    return _prefs?.getString(StorageKeys.authToken);
  }

  // Save user data
  Future<bool> saveUserData({
    required String userId,
    required String email,
    required String name,
  }) async {
    final results = await Future.wait([
      _prefs?.setString(StorageKeys.userId, userId) ?? Future.value(false),
      _prefs?.setString(StorageKeys.userEmail, email) ?? Future.value(false),
      _prefs?.setString(StorageKeys.userName, name) ?? Future.value(false),
    ]);
    return results.every((result) => result);
  }

  // Get user ID
  String? getUserId() {
    return _prefs?.getString(StorageKeys.userId);
  }

  // Get user email
  String? getUserEmail() {
    return _prefs?.getString(StorageKeys.userEmail);
  }

  // Get user name
  String? getUserName() {
    return _prefs?.getString(StorageKeys.userName);
  }

  // Clear all data
  Future<bool> clearAll() async {
    return await _prefs?.clear() ?? false;
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return getAuthToken() != null;
  }
}
