import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
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

  const AuthEntity({
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

  @override
  List<Object?> get props => <Object?>[
    accessToken,
    refreshToken,
    userId,
    email,
    firstName,
    lastName,
    roles,
    phoneNumber,
    address,
    profileImageUrl,
  ];
}
