import 'package:yallakhadra/features/reports/domain/entities/nearby_reports_page_entity.dart';
import 'package:yallakhadra/features/reports/domain/repositories/reports_repository.dart';

class GetNearbyReportsParams {
  final double latitude;
  final double longitude;
  final double? radiusInKm;
  final int pageNumber;
  final int pageSize;

  const GetNearbyReportsParams({
    required this.latitude,
    required this.longitude,
    this.radiusInKm,
    required this.pageNumber,
    required this.pageSize,
  });
}

class GetNearbyReportsUseCase {
  final ReportsRepository repository;

  const GetNearbyReportsUseCase(this.repository);

  Future<NearbyReportsPageEntity> call(GetNearbyReportsParams params) {
    return repository.getNearbyReports(
      latitude: params.latitude,
      longitude: params.longitude,
      radiusInKm: params.radiusInKm,
      pageNumber: params.pageNumber,
      pageSize: params.pageSize,
    );
  }
}
