import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/network/endpoints.dart';
import 'package:yallakhadra/core/network/network_service.dart';
import 'package:yallakhadra/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:yallakhadra/features/profile/data/models/change_password_model.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final NetworkService _networkService;

  ProfileRemoteDataSourceImpl(this._networkService);

  @override
  Future<Either<Failure, ChangePasswordModel>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    final result = await _networkService.patchData(
      endPoint: EndPoints.changePassword,
      data: <String, dynamic>{
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'confirmNewPassword': confirmNewPassword,
      },
    );

    return result.fold(
      (String message) {
        final String errorMessage = message.trim().isEmpty
            ? 'Unable to change password.'
            : message;

        return Left(ServerFailure(message: errorMessage));
      },
      (dynamic data) {
        if (data is! Map<String, dynamic>) {
          return const Left(ServerFailure(message: 'Invalid server response'));
        }

        final ChangePasswordModel model = ChangePasswordModel.fromJson(data);
        if (!model.succeeded) {
          final String failureMessage = model.errors.isNotEmpty
              ? model.errors.first
              : model.message;

          return Left(
            ServerFailure(
              message: failureMessage.isEmpty
                  ? 'Unable to change password.'
                  : failureMessage,
            ),
          );
        }

        return Right(model);
      },
    );
  }
}
