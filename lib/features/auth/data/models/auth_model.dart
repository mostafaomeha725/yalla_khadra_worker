import 'package:yallakhadra/features/auth/domain/entities/auth_entity.dart';

class AuthModel {
  final String accessToken;
  final String refreshToken;
  final int userId;
  final String email;
  final String firstName;
  final String lastName;
  final List<int> roles;
  final String phoneNumber;
  final String address;
  final String profileImageUrl;

  const AuthModel({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.roles,
    required this.phoneNumber,
    required this.address,
    required this.profileImageUrl,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data =
        (json['data'] as Map<String, dynamic>?) ?? <String, dynamic>{};

    final dynamic refreshRaw = data['refreshToken'];
    final Map<String, dynamic> refreshData = refreshRaw is Map<String, dynamic>
        ? refreshRaw
        : <String, dynamic>{};
    final String refreshTokenValue = refreshRaw is String
        ? refreshRaw
        : refreshData['token'] as String? ?? '';

    final Map<String, dynamic> userData =
        (data['user'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final Map<String, dynamic> profileImageData =
        (userData['profileImage'] as Map<String, dynamic>?) ??
        <String, dynamic>{};

    return AuthModel(
      accessToken: data['accessToken'] as String? ?? '',
      refreshToken: refreshTokenValue,
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
      phoneNumber: (userData['phoneNumber'] as String? ?? '').trim(),
      address: (userData['address'] as String? ?? '').trim(),
      profileImageUrl: (profileImageData['url'] as String? ?? '').trim(),
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
      'phoneNumber': phoneNumber,
      'address': address,
      'profileImageUrl': profileImageUrl,
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
      phoneNumber: phoneNumber,
      address: address,
      profileImageUrl: profileImageUrl,
    );
  }
}
