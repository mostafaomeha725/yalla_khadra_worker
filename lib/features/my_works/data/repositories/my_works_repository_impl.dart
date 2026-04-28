import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/di/services_locator.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/network/network_service.dart';
import 'package:yallakhadra/features/my_works/data/data_sources/my_works_remote_data_source.dart';
import 'package:yallakhadra/features/my_works/data/data_sources/my_works_remote_data_source_impl.dart';
import 'package:yallakhadra/features/my_works/domain/entities/my_work_overview_entity.dart';
import 'package:yallakhadra/features/my_works/domain/entities/my_work_reports_page_entity.dart';
import 'package:yallakhadra/features/my_works/domain/repositories/my_works_repository.dart';

class MyWorksRepositoryImpl implements MyWorksRepository {
  final MyWorksRemoteDataSource _remoteDataSource;

  MyWorksRepositoryImpl({MyWorksRemoteDataSource? remoteDataSource})
    : _remoteDataSource =
          remoteDataSource ?? MyWorksRemoteDataSourceImpl(sl<NetworkService>());

  @override
  Future<Either<Failure, MyWorkOverviewEntity>> getMyWorkOverview() async {
    final result = await _remoteDataSource.getMyWorkOverview();

    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Either<Failure, MyWorkReportsPageEntity>> getMyWorkReports({
    required int pageNumber,
    required int pageSize,
  }) async {
    final result = await _remoteDataSource.getMyWorkReports(
      pageNumber: pageNumber,
      pageSize: pageSize,
    );

    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model.toEntity()),
    );
  }
}
