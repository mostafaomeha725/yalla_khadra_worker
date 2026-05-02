import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/features/profile/data/models/change_password_model.dart';
import 'package:yallakhadra/features/profile/data/models/update_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<Either<Failure, ChangePasswordModel>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  });

  Future<Either<Failure, String>> logout({required String refreshToken});

  Future<Either<Failure, UpdateProfileModel>> updateProfile({
    required int userId,
    required String firstName,
    required String lastName,
    required String address,
    required String phoneNumber,
    String? profileImagePath,
  });
}
