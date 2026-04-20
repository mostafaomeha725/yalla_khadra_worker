import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/network/endpoints.dart';
import 'package:yallakhadra/core/network/network_service.dart';
import 'package:yallakhadra/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:yallakhadra/features/auth/data/data_sources/auth_response_parser.dart';
import 'package:yallakhadra/features/auth/data/models/auth_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final NetworkService _networkService;

  AuthRemoteDataSourceImpl(this._networkService);

  @override
  Future<Either<Failure, String>> requestPasswordReset({
    required String email,
  }) async {
    final result = await _networkService.postData(
      endPoint: EndPoints.forgotPassword,
      data: <String, dynamic>{'email': email},
    );

    return result.fold(
      (failure) => parseFailureResponse(
        failure: failure,
        defaultFailure: 'Unable to send password reset email.',
      ),
      (data) => parseMessageResponse(
        data: data,
        defaultFailure: 'Unable to send password reset email.',
        defaultSuccess: 'Password reset email sent successfully.',
      ),
    );
  }

  @override
  Future<Either<Failure, bool>> verifyPasswordResetCode({
    required String email,
    required String code,
  }) async {
    final result = await _networkService.postData(
      endPoint: EndPoints.verifyPasswordResetCode,
      data: <String, dynamic>{'email': email, 'code': code},
    );

    return result.fold(
      (failure) => parseFailureResponse(
        failure: failure,
        defaultFailure: 'Unable to verify reset code.',
      ),
      (data) => parseVerifyCodeResponse(
        data: data,
        defaultFailure: 'Unable to verify reset code.',
      ),
    );
  }

  @override
  Future<Either<Failure, String>> confirmPasswordReset({
    required String email,
    required String code,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    final result = await _networkService.postData(
      endPoint: EndPoints.confirmPasswordReset,
      data: <String, dynamic>{
        'email': email,
        'code': code,
        'newPassword': newPassword,
        'confirmNewPassword': confirmNewPassword,
      },
    );

    return result.fold(
      (failure) => parseFailureResponse(
        failure: failure,
        defaultFailure: 'Unable to reset password.',
      ),
      (data) => parseMessageResponse(
        data: data,
        defaultFailure: 'Unable to reset password.',
        defaultSuccess: 'Password reset successfully.',
      ),
    );
  }

  @override
  Future<Either<Failure, AuthModel>> login({
    required String email,
    required String password,
  }) async {
    final result = await _networkService.postData(
      endPoint: EndPoints.login,
      data: <String, dynamic>{'email': email, 'password': password},
    );

    return result.fold((failure) => Left(failure), (data) {
      if (data is! Map<String, dynamic>) {
        return const Left(ServerFailure(message: 'Invalid server response'));
      }

      final bool succeeded = data['succeeded'] as bool? ?? false;
      if (!succeeded) {
        final String message = data['message'] as String? ?? 'Login failed';
        return Left(ServerFailure(message: message));
      }

      final AuthModel model = AuthModel.fromJson(data);
      if (model.accessToken.isEmpty || model.refreshToken.isEmpty) {
        return const Left(ServerFailure(message: 'Missing auth tokens'));
      }
      return Right(model);
    });
  }
}
