import 'package:yallakhadra/features/auth/domain/entities/auth_entity.dart';

class AuthModel {
  final String accessToken;
  final String refreshToken;
  final int userId;
  final String email;
  final String firstName;
  final String lastName;
  final List<int> roles;

  const AuthModel({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.roles,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data =
        (json['data'] as Map<String, dynamic>?) ?? <String, dynamic>{};

    final Map<String, dynamic> refreshData =
        (data['refreshToken'] as Map<String, dynamic>?) ?? <String, dynamic>{};

    final Map<String, dynamic> userData =
        (data['user'] as Map<String, dynamic>?) ?? <String, dynamic>{};

    return AuthModel(
      accessToken: data['accessToken'] as String? ?? '',
      refreshToken: refreshData['token'] as String? ?? '',
      userId:
          (userData['id'] as num?)?.toInt() ??
          (refreshData['userId'] as num?)?.toInt() ??
          0,
      email: userData['email'] as String? ?? '',
      firstName: userData['firstName'] as String? ?? '',
      lastName: userData['lastName'] as String? ?? '',
      roles: (userData['roles'] as List<dynamic>? ?? <dynamic>[])
          .whereType<num>()
          .map((num role) => role.toInt())
          .toList(growable: false),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'userId': userId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'roles': roles,
    };
  }

  AuthEntity toEntity() {
    return AuthEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
      userId: userId,
      email: email,
      firstName: firstName,
      lastName: lastName,
      roles: roles,
    );
  }
}
