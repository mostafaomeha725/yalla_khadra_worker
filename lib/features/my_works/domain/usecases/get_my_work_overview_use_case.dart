import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/usecase/base_usecase.dart';
import 'package:yallakhadra/features/my_works/domain/entities/my_work_overview_entity.dart';
import 'package:yallakhadra/features/my_works/domain/repositories/my_works_repository.dart';

class GetMyWorkOverviewUseCase extends UseCase<MyWorkOverviewEntity, NoParams> {
  final MyWorksRepository _repository;

  GetMyWorkOverviewUseCase(this._repository);

  @override
  Future<Either<Failure, MyWorkOverviewEntity>> call(NoParams params) {
    return _repository.getMyWorkOverview();
  }
}
