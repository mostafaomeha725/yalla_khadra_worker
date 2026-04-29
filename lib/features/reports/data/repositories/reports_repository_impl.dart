import 'package:yallakhadra/core/di/services_locator.dart';
import 'package:yallakhadra/core/network/network_service.dart';
import 'package:yallakhadra/features/reports/data/data_sources/reports_remote_data_source.dart';
import 'package:yallakhadra/features/reports/data/data_sources/reports_remote_data_source_impl.dart';
import 'package:yallakhadra/features/reports/domain/entities/nearby_reports_page_entity.dart';
import 'package:yallakhadra/features/reports/domain/repositories/reports_repository.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  final ReportsRemoteDataSource _remoteDataSource;

  ReportsRepositoryImpl({ReportsRemoteDataSource? remoteDataSource})
    : _remoteDataSource =
          remoteDataSource ?? ReportsRemoteDataSourceImpl(sl<NetworkService>());

  @override
  Future<NearbyReportsPageEntity> getNearbyReports({
    required double latitude,
    required double longitude,
    double? radiusInKm,
    required int pageNumber,
    required int pageSize,
  }) async {
    final result = await _remoteDataSource.getNearbyReports(
      latitude: latitude,
      longitude: longitude,
      radiusInKm: radiusInKm,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (model) => model.toEntity(),
    );
  }
}
