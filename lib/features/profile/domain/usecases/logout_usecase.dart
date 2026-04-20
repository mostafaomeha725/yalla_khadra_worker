import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/usecase/base_usecase.dart';
import 'package:yallakhadra/features/profile/domain/repositories/profile_repository.dart';

class LogoutUseCase extends UseCase<String, NoParams> {
  final ProfileRepository _repository;

  LogoutUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return _repository.logout();
  }
}
