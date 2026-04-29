import 'package:yallakhadra/features/reports/domain/entities/nearby_report_entity.dart';

class NearbyReportsPageEntity {
  final List<NearbyReportEntity> reports;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final int pageSize;
  final bool hasPreviousPage;
  final bool hasNextPage;

  const NearbyReportsPageEntity({
    required this.reports,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.pageSize,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });
}
