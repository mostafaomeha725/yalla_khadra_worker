import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/usecase/base_usecase.dart';
import 'package:yallakhadra/features/my_works/domain/entities/my_work_reports_page_entity.dart';
import 'package:yallakhadra/features/my_works/domain/repositories/my_works_repository.dart';

class GetMyWorkReportsUseCase
    extends UseCase<MyWorkReportsPageEntity, MyWorkReportsParams> {
  final MyWorksRepository _repository;

  GetMyWorkReportsUseCase(this._repository);

  @override
  Future<Either<Failure, MyWorkReportsPageEntity>> call(
    MyWorkReportsParams params,
  ) {
    return _repository.getMyWorkReports(
      pageNumber: params.pageNumber,
      pageSize: params.pageSize,
    );
  }
}

class MyWorkReportsParams extends Equatable {
  final int pageNumber;
  final int pageSize;

  const MyWorkReportsParams({required this.pageNumber, required this.pageSize});

  @override
  List<Object> get props => [pageNumber, pageSize];
}
