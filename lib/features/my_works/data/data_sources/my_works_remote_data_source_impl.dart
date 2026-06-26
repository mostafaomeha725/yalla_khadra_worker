import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/network/endpoints.dart';
import 'package:yallakhadra/core/network/network_service.dart';
import 'package:yallakhadra/features/my_works/data/data_sources/my_works_remote_data_source.dart';
import 'package:yallakhadra/features/my_works/data/models/my_work_details_model.dart';
import 'package:yallakhadra/features/my_works/data/models/my_work_overview_model.dart';
import 'package:yallakhadra/features/my_works/data/models/my_work_reports_page_model.dart';

class MyWorksRemoteDataSourceImpl implements MyWorksRemoteDataSource {
  final NetworkService _networkService;

  MyWorksRemoteDataSourceImpl(this._networkService);

  @override
  Future<Either<Failure, MyWorkOverviewModel>> getMyWorkOverview() async {
    final result = await _networkService.getData(
      endPoint: EndPoints.cleanupTaskMyWorkOverview,
    );

    return result.fold((failure) => Left(failure), (data) {
      if (data is! Map<String, dynamic>) {
        return const Left(ServerFailure(message: 'Invalid server response'));
      }

      final bool succeeded =
          (data['succeeded'] as bool?) ??
          (data['Succeeded'] as bool?) ??
          (data['statusCode'] as num?) == 200;

      if (!succeeded) {
        return Left(
          ServerFailure(
            message: MyWorkOverviewModel.extractFailureMessage(data),
          ),
        );
      }

      return Right(MyWorkOverviewModel.fromJson(data));
    });
  }

  @override
  Future<Either<Failure, MyWorkReportsPageModel>> getMyWorkReports({
    required int pageNumber,
    required int pageSize,
  }) async {
    final result = await _networkService.getData(
      endPoint: EndPoints.wasteReportMyWork,
      queryParameters: <String, dynamic>{
        'PageNumber': pageNumber,
        'PageSize': pageSize,
      },
    );

    return result.fold((failure) => Left(failure), (data) {
      if (data is! Map<String, dynamic>) {
        return const Left(ServerFailure(message: 'Invalid server response'));
      }

      final bool succeeded =
          (data['succeeded'] as bool?) ??
          (data['Succeeded'] as bool?) ??
          (data['statusCode'] as num?) == 200;

      if (!succeeded) {
        return Left(
          ServerFailure(
            message: MyWorkOverviewModel.extractFailureMessage(
              data,
              fallback: 'Unable to load my works.',
            ),
          ),
        );
      }

      return Right(MyWorkReportsPageModel.fromJson(data));
    });
  }

  @override
  Future<Either<Failure, MyWorkDetailsModel>> getCompletedWorkDetails(
    int id,
  ) async {
    final result = await _networkService.getData(
      endPoint: '${EndPoints.wasteReport}/$id',
    );

    return result.fold((failure) => Left(failure), (data) {
      if (data is! Map<String, dynamic>) {
        return const Left(ServerFailure(message: 'Invalid server response'));
      }

      final bool succeeded =
          (data['succeeded'] as bool?) ??
          (data['Succeeded'] as bool?) ??
          (data['statusCode'] as num?) == 200;

      if (!succeeded) {
        return Left(
          ServerFailure(
            message: MyWorkOverviewModel.extractFailureMessage(
              data,
              fallback: 'Unable to load work details.',
            ),
          ),
        );
      }

      return Right(MyWorkDetailsModel.fromJson(data));
    });
  }
}
