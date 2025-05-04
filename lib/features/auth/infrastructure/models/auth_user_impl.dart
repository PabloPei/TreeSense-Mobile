import 'package:treesense/features/auth/domain/entities/auth_user.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class AuthUserModel implements AuthUser {
  @override
  final String email;
  
  @override
  final String accessToken;
  
  @override
  final String refreshToken;

  const AuthUserModel({
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
  
  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    final accessToken = json['accessToken'];

    final jwt = JWT.decode(accessToken);
    final email = jwt.payload['email'];

    return AuthUserModel(
      email: email,
      accessToken: accessToken,
      refreshToken: json['refreshToken'],
    );
  }
}
