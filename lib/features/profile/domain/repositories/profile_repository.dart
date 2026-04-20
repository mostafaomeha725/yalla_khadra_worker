import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/features/profile/domain/entities/change_password_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ChangePasswordEntity>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  });

  Future<Either<Failure, String>> logout();
}
