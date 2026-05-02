import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/usecase/base_usecase.dart';
import 'package:yallakhadra/features/profile/domain/entities/update_profile_entity.dart';
import 'package:yallakhadra/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase
    extends UseCase<UpdateProfileEntity, UpdateProfileParams> {
  final ProfileRepository _repository;

  UpdateProfileUseCase(this._repository);

  @override
  Future<Either<Failure, UpdateProfileEntity>> call(
    UpdateProfileParams params,
  ) {
    return _repository.updateProfile(
      userId: params.userId,
      firstName: params.firstName,
      lastName: params.lastName,
      address: params.address,
      phoneNumber: params.phoneNumber,
      profileImagePath: params.profileImagePath,
    );
  }
}

class UpdateProfileParams extends Equatable {
  final int userId;
  final String firstName;
  final String lastName;
  final String address;
  final String phoneNumber;
  final String? profileImagePath;

  const UpdateProfileParams({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.phoneNumber,
    this.profileImagePath,
  });

  @override
  List<Object?> get props => <Object?>[
    userId,
    firstName,
    lastName,
    address,
    phoneNumber,
    profileImagePath,
  ];
}
