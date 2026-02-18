import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';
import '../models/login_model.dart';
import '../models/signup_model.dart';

class AuthRepository {
  final http.Client _client;

  AuthRepository({http.Client? client}) : _client = client ?? http.Client();

  // Sign In
  Future<LoginResponse> signIn(LoginRequest request) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiConstants.signInUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginResponse.fromJson(responseData);
      } else {
        return LoginResponse(
          success: false,
          message: responseData['message'] ?? 'Sign in failed',
        );
      }
    } catch (e) {
      return LoginResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Sign Up
  Future<SignUpResponse> signUp(SignUpRequest request) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiConstants.signUpUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return SignUpResponse.fromJson(responseData);
      } else {
        return SignUpResponse(
          success: false,
          message: responseData['message'] ?? 'Sign up failed',
        );
      }
    } catch (e) {
      return SignUpResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  void dispose() {
    _client.close();
  }
}
