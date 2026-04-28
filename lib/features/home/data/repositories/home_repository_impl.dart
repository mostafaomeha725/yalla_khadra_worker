import 'package:yallakhadra/core/di/services_locator.dart';
import 'package:yallakhadra/core/helpers/helpers.dart';
import 'package:yallakhadra/core/network/network_service.dart';
import 'package:yallakhadra/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:yallakhadra/features/home/data/data_sources/home_remote_data_source_impl.dart';
import 'package:yallakhadra/features/home/data/models/home_current_cleanup_task_model.dart';
import 'package:yallakhadra/features/home/data/models/home_main_overview_model.dart';
import 'package:yallakhadra/features/home/domain/entities/home_cleanup_task_entity.dart';
import 'package:yallakhadra/features/home/domain/entities/home_dashboard_entity.dart';
import 'package:yallakhadra/features/home/domain/entities/home_nearby_report_entity.dart';
import 'package:yallakhadra/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepositoryImpl({HomeRemoteDataSource? remoteDataSource})
    : _remoteDataSource =
          remoteDataSource ?? HomeRemoteDataSourceImpl(sl<NetworkService>());

  @override
  Future<HomeDashboardEntity> getHomeDashboard() async {
    final overviewResult = await _remoteDataSource.getMainOverview();
    final currentCleanupResult = await _remoteDataSource.getMyUncompletedTask();

    final HomeMainOverviewModel overview = overviewResult.fold(
      (failure) => throw Exception(failure.message),
      (model) => model,
    );

    final HomeCurrentCleanupTaskModel? currentCleanup = currentCleanupResult
        .fold((failure) => null, (model) => model);
    final String distance = currentCleanup == null
        ? 'Distance unavailable'
        : await Helpers.formatDistanceFromCurrentLocation(
            targetLatitude: currentCleanup.latitude,
            targetLongitude: currentCleanup.longitude,
          );
    final String takenTime = currentCleanup == null
        ? 'Taken recently'
        : Helpers.formatTakenTimeAgo(currentCleanup.timeAgo);

    return HomeDashboardEntity(
      workerName: 'Ahmed',
      avgHours: overview.averageHours,
      completedCount: overview.completedCleanupsCount,
      currentCleanup: HomeCleanupTaskEntity(
        taskId: currentCleanup?.taskId ?? 0,
        title: currentCleanup?.address ?? 'No Active Cleanup',
        subTitle: '',
        distance: distance,
        wasteType: currentCleanup?.wasteType ?? 'Unknown',
        status: 'In Progress',
        timeAgo: takenTime,
        imageUrl: currentCleanup?.imageUrl.isNotEmpty == true
            ? currentCleanup!.imageUrl
            : 'https://images.pexels.com/photos/3735657/pexels-photo-3735657.jpeg?auto=compress&cs=tinysrgb&w=600',
        imageUrls: currentCleanup?.imageUrls ?? const <String>[],
        latitude: currentCleanup?.latitude ?? 0,
        longitude: currentCleanup?.longitude ?? 0,
        locationQuery: currentCleanup?.address.trim().isNotEmpty == true
            ? currentCleanup!.address
            : '${currentCleanup?.latitude ?? 0},${currentCleanup?.longitude ?? 0}',
      ),
      nearbyReports: [
        const HomeNearbyReportEntity(
          title: 'Al Wahda Street, near',
          distance: '0.8 km',
          timeAgo: '2 hours ago',
          wasteType: 'Plastic Bottles',
          imageUrl:
              'https://images.pexels.com/photos/3735657/pexels-photo-3735657.jpeg?auto=compress&cs=tinysrgb&w=600',
        ),
        const HomeNearbyReportEntity(
          title: 'Khalifa Park, East Entrance',
          distance: '1.2 km',
          timeAgo: '3 hours ago',
          wasteType: 'Mixed Waste',
          imageUrl:
              'https://images.pexels.com/photos/48195/document-agreement-documents-sign-48195.jpeg?auto=compress&cs=tinysrgb&w=600',
        ),
        const HomeNearbyReportEntity(
          title: 'Marina Beach Area',
          distance: '2.5 km',
          timeAgo: '5 hours ago',
          wasteType: 'Glass Bottles',
          imageUrl:
              'https://images.pexels.com/photos/802221/pexels-photo-802221.jpeg?auto=compress&cs=tinysrgb&w=600',
        ),
      ],
    );
  }

  @override
  Future<void> completeCleanupTask({
    required int taskId,
    required int finalWasteType,
    required String finalWeightInKg,
    required List<String> imagePaths,
  }) async {
    final result = await _remoteDataSource.completeCleanupTask(
      taskId: taskId,
      finalWasteType: finalWasteType,
      finalWeightInKg: finalWeightInKg,
      imagePaths: imagePaths,
    );

    result.fold((failure) => throw Exception(failure.message), (_) => null);
  }
}
