import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/usecase/base_usecase.dart';
import 'package:yallakhadra/features/profile/domain/entities/change_password_entity.dart';
import 'package:yallakhadra/features/profile/domain/repositories/profile_repository.dart';

class ChangePasswordUseCase
    extends UseCase<ChangePasswordEntity, ChangePasswordParams> {
  final ProfileRepository _repository;

  ChangePasswordUseCase(this._repository);

  @override
  Future<Either<Failure, ChangePasswordEntity>> call(
    ChangePasswordParams params,
  ) {
    return _repository.changePassword(
      currentPassword: params.currentPassword,
      newPassword: params.newPassword,
      confirmNewPassword: params.confirmNewPassword,
    );
  }
}

class ChangePasswordParams extends Equatable {
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;

  const ChangePasswordParams({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  @override
  List<Object?> get props => <Object?>[
    currentPassword,
    newPassword,
    confirmNewPassword,
  ];
}
