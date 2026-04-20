import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/usecase/base_usecase.dart';
import 'package:yallakhadra/features/auth/domain/entities/auth_entity.dart';
import 'package:yallakhadra/features/auth/domain/repositories/auth_repository.dart';

class AuthUseCase extends UseCase<AuthEntity, AuthParams> {
  final AuthRepository _repository;

  AuthUseCase(this._repository);

  @override
  Future<Either<Failure, AuthEntity>> call(AuthParams params) {
    return _repository.login(email: params.email, password: params.password);
  }
}

class AuthParams extends Equatable {
  final String email;
  final String password;

  const AuthParams({required this.email, required this.password});

  @override
  List<Object?> get props => <Object?>[email, password];
}
