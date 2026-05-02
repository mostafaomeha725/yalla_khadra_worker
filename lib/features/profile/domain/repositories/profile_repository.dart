import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/features/profile/domain/entities/change_password_entity.dart';
import 'package:yallakhadra/features/profile/domain/entities/update_profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ChangePasswordEntity>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  });

  Future<Either<Failure, String>> logout();

  Future<Either<Failure, UpdateProfileEntity>> updateProfile({
    required int userId,
    required String firstName,
    required String lastName,
    required String address,
    required String phoneNumber,
    String? profileImagePath,
  });
}
