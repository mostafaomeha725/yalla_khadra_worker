import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/usecase/base_usecase.dart';
import 'package:yallakhadra/features/my_works/domain/entities/my_work_details_entity.dart';
import 'package:yallakhadra/features/my_works/domain/repositories/my_works_repository.dart';

class GetCompletedWorkDetailsUseCase implements UseCase<MyWorkDetailsEntity, int> {
  final MyWorksRepository _repository;

  GetCompletedWorkDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, MyWorkDetailsEntity>> call(int id) async {
    return await _repository.getCompletedWorkDetails(id);
  }
}
