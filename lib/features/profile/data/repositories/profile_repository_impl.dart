import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/cache/preferences_storage.dart';
import 'package:yallakhadra/core/cache/preferences_storage_keys.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:yallakhadra/features/profile/domain/entities/change_password_entity.dart';
import 'package:yallakhadra/features/profile/domain/entities/update_profile_entity.dart';
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

  @override
  Future<Either<Failure, UpdateProfileEntity>> updateProfile({
    required int userId,
    required String firstName,
    required String lastName,
    required String address,
    required String phoneNumber,
    String? profileImagePath,
  }) async {
    final result = await _remoteDataSource.updateProfile(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      address: address,
      phoneNumber: phoneNumber,
      profileImagePath: profileImagePath,
    );

    return result.fold((Failure failure) => Left(failure), (model) async {
      await _preferencesStorage.saveUserProfile(
        firstName: firstName,
        lastName: lastName,
        email: _preferencesStorage.getEmail(),
      );
      await _preferencesStorage.putString(
        key: PreferencesKeys.phone,
        value: phoneNumber,
      );
      await _preferencesStorage.saveAddress(address);
      if (profileImagePath != null && profileImagePath.trim().isNotEmpty) {
        await _preferencesStorage.putString(
          key: PreferencesKeys.picture,
          value: profileImagePath,
        );
      }
      return Right(model.toEntity());
    });
  }
}
