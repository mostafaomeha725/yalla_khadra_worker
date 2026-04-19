import 'package:yallakhadra/features/home/domain/entities/home_cleanup_task_entity.dart';
import 'package:yallakhadra/features/home/domain/entities/home_nearby_report_entity.dart';

class HomeDashboardEntity {
  final String workerName;
  final int avgMinutes;
  final int completedCount;
  final HomeCleanupTaskEntity currentCleanup;
  final List<HomeNearbyReportEntity> nearbyReports;

  const HomeDashboardEntity({
    required this.workerName,
    required this.avgMinutes,
    required this.completedCount,
    required this.currentCleanup,
    required this.nearbyReports,
  });
}
