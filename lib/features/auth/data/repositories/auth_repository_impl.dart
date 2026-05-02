import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/cache/preferences_storage.dart';
import 'package:yallakhadra/core/cache/preferences_storage_keys.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:yallakhadra/features/auth/domain/entities/auth_entity.dart';
import 'package:yallakhadra/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final PreferencesStorage _preferencesStorage;

  AuthRepositoryImpl(this._remoteDataSource, this._preferencesStorage);

  @override
  Future<Either<Failure, String>> requestPasswordReset({
    required String email,
  }) async {
    return _remoteDataSource.requestPasswordReset(email: email);
  }

  @override
  Future<Either<Failure, bool>> verifyPasswordResetCode({
    required String email,
    required String code,
  }) async {
    return _remoteDataSource.verifyPasswordResetCode(email: email, code: code);
  }

  @override
  Future<Either<Failure, String>> confirmPasswordReset({
    required String email,
    required String code,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    return _remoteDataSource.confirmPasswordReset(
      email: email,
      code: code,
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
    );
  }

  @override
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
  }) async {
    final result = await _remoteDataSource.login(
      email: email,
      password: password,
    );

    return result.fold((Failure failure) async => Left(failure), (
      authModel,
    ) async {
      final bool isWorker = authModel.roles.contains(2);
      if (!isWorker) {
        await _preferencesStorage.deleteUserToken();
        await _preferencesStorage.deleteRefreshToken();
        await _preferencesStorage.clearUserProfile();
        return const Left(ServerFailure(message: 'Invalid Email or password'));
      }

      await _preferencesStorage.saveUserToken(authModel.accessToken);
      await _preferencesStorage.saveRefreshToken(authModel.refreshToken);
      await _preferencesStorage.saveUserId(authModel.userId);
      await _preferencesStorage.saveUserProfile(
        firstName: authModel.firstName,
        lastName: authModel.lastName,
        email: authModel.email,
      );
      await _preferencesStorage.putString(
        key: PreferencesKeys.phone,
        value: authModel.phoneNumber,
      );
      await _preferencesStorage.saveAddress(authModel.address);
      await _preferencesStorage.putString(
        key: PreferencesKeys.picture,
        value: authModel.profileImageUrl,
      );
      return Right(authModel.toEntity());
    });
  }
}
