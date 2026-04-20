import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/usecase/base_usecase.dart';
import 'package:yallakhadra/features/auth/domain/repositories/auth_repository.dart';

class RequestPasswordResetUseCase
    extends UseCase<String, RequestPasswordResetParams> {
  final AuthRepository _repository;

  RequestPasswordResetUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(RequestPasswordResetParams params) {
    return _repository.requestPasswordReset(email: params.email);
  }
}

class RequestPasswordResetParams extends Equatable {
  final String email;

  const RequestPasswordResetParams({required this.email});

  @override
  List<Object?> get props => <Object?>[email];
}
