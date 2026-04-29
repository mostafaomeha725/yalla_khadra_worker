import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/features/reports/data/models/nearby_reports_page_model.dart';

abstract class ReportsRemoteDataSource {
  Future<Either<Failure, NearbyReportsPageModel>> getNearbyReports({
    double? latitude,
    double? longitude,
    double? radiusInKm,
    required int pageNumber,
    required int pageSize,
  });
}
