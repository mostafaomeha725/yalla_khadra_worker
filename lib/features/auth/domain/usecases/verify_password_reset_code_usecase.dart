import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/usecase/base_usecase.dart';
import 'package:yallakhadra/features/auth/domain/repositories/auth_repository.dart';

class VerifyPasswordResetCodeUseCase
    extends UseCase<bool, VerifyPasswordResetCodeParams> {
  final AuthRepository _repository;

  VerifyPasswordResetCodeUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(VerifyPasswordResetCodeParams params) {
    return _repository.verifyPasswordResetCode(
      email: params.email,
      code: params.code,
    );
  }
}

class VerifyPasswordResetCodeParams extends Equatable {
  final String email;
  final String code;

  const VerifyPasswordResetCodeParams({
    required this.email,
    required this.code,
  });

  @override
  List<Object?> get props => <Object?>[email, code];
}
