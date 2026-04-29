import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/cache/preferences_storage.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:yallakhadra/features/profile/domain/entities/change_password_entity.dart';
import 'package:yallakhadra/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;
  final PreferencesStorage _preferencesStorage;

  ProfileRepositoryImpl(this._remoteDataSource, this._preferencesStorage);

  @override
  Future<Either<Failure, String>> logout() async {
    final String refreshToken = (_preferencesStorage.getRefreshToken() ?? '')
        .trim();

    if (refreshToken.isEmpty) {
      await _preferencesStorage.deleteUserToken();
      await _preferencesStorage.deleteRefreshToken();
      await _preferencesStorage.clearUserProfile();
      return const Right('Logged out successfully.');
    }

    final result = await _remoteDataSource.logout(refreshToken: refreshToken);

    // Completely clear user data locally regardless of API success or failure,
    // to ensure the user is not stuck if the token is expired or network is down.
    await _preferencesStorage.deleteUserToken();
    await _preferencesStorage.deleteRefreshToken();
    await _preferencesStorage.clearUserProfile();

    return result.fold(
      (Failure failure) => const Right(
        'Logged out successfully.',
      ), // Ignore server errors like token expiration
      (String message) => Right(message),
    );
  }

  @override
  Future<Either<Failure, ChangePasswordEntity>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    final result = await _remoteDataSource.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
    );

    return result.fold(
      (Failure failure) => Left(failure),
      (model) => Right(model.toEntity()),
    );
  }
}
