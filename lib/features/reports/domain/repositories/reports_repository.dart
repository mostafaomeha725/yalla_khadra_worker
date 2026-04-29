import 'package:yallakhadra/features/reports/domain/entities/nearby_reports_page_entity.dart';

abstract class ReportsRepository {
  Future<NearbyReportsPageEntity> getNearbyReports({
    double? latitude,
    double? longitude,
    double? radiusInKm,
    required int pageNumber,
    required int pageSize,
  });

  Future<String> assignReport(int reportId);
}
