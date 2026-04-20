import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/features/auth/data/models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, AuthModel>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> requestPasswordReset({required String email});

  Future<Either<Failure, bool>> verifyPasswordResetCode({
    required String email,
    required String code,
  });

  Future<Either<Failure, String>> confirmPasswordReset({
    required String email,
    required String code,
    required String newPassword,
    required String confirmNewPassword,
  });
}
