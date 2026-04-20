import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/usecase/base_usecase.dart';
import 'package:yallakhadra/features/auth/domain/repositories/auth_repository.dart';

class ConfirmPasswordResetUseCase
    extends UseCase<String, ConfirmPasswordResetParams> {
  final AuthRepository _repository;

  ConfirmPasswordResetUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(ConfirmPasswordResetParams params) {
    return _repository.confirmPasswordReset(
      email: params.email,
      code: params.code,
      newPassword: params.newPassword,
      confirmNewPassword: params.confirmNewPassword,
    );
  }
}

class ConfirmPasswordResetParams extends Equatable {
  final String email;
  final String code;
  final String newPassword;
  final String confirmNewPassword;

  const ConfirmPasswordResetParams({
    required this.email,
    required this.code,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  @override
  List<Object?> get props => <Object?>[
    email,
    code,
    newPassword,
    confirmNewPassword,
  ];
}
