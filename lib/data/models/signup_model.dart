import 'user_model.dart';

class SignUpRequest {
  final String name;
  final String email;
  final String password;

  SignUpRequest({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}

class SignUpResponse {
  final bool success;
  final String message;
  final SignUpData? data;

  SignUpResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? SignUpData.fromJson(json['data']) : null,
    );
  }
}

class SignUpData {
  final String token;
  final User user;

  SignUpData({
    required this.token,
    required this.user,
  });

  factory SignUpData.fromJson(Map<String, dynamic> json) {
    return SignUpData(
      token: json['token'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
    );
  }
}
