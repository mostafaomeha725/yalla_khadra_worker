import 'package:yallakhadra/features/home/domain/entities/home_dashboard_entity.dart';

abstract class HomeRepository {
  Future<HomeDashboardEntity> getHomeDashboard();

  Future<void> completeCleanupTask({
    required int taskId,
    required int finalWasteType,
    required String finalWeightInKg,
    required List<String> imagePaths,
  });

  Future<void> updateUserLocation({
    required double latitude,
    required double longitude,
  });
}
