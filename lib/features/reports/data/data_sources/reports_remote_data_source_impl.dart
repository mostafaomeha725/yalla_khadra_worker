import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/network/endpoints.dart';
import 'package:yallakhadra/core/network/network_service.dart';
import 'package:yallakhadra/features/home/data/models/home_main_overview_model.dart';
import 'package:yallakhadra/features/reports/data/data_sources/reports_remote_data_source.dart';
import 'package:yallakhadra/features/reports/data/models/nearby_reports_page_model.dart';

class ReportsRemoteDataSourceImpl implements ReportsRemoteDataSource {
  final NetworkService _networkService;

  ReportsRemoteDataSourceImpl(this._networkService);

  @override
  Future<Either<Failure, NearbyReportsPageModel>> getNearbyReports({
    double? latitude,
    double? longitude,
    double? radiusInKm,
    required int pageNumber,
    required int pageSize,
  }) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{
      if (latitude != null) 'Latitude': latitude,
      if (longitude != null) 'Longitude': longitude,
      if (radiusInKm != null) 'RadiusInKm': radiusInKm,
      'PageNumber': pageNumber,
      'PageSize': pageSize,
    };

    final result = await _networkService.getData(
      endPoint: EndPoints.wasteReportNear,
      queryParameters: queryParameters,
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
            message: HomeMainOverviewModel.extractFailureMessage(
              data,
              fallback: 'Unable to load nearby reports.',
            ),
          ),
        );
      }

      return Right(NearbyReportsPageModel.fromJson(data));
    });
  }
}
