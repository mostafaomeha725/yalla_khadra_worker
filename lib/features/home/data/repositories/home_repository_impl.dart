import 'package:geolocator/geolocator.dart';
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

    final List<HomeCurrentCleanupTaskModel> currentCleanups =
        currentCleanupResult.fold(
          (failure) => <HomeCurrentCleanupTaskModel>[],
          (models) => models,
        );

    Position? userPosition;
    if (currentCleanups.isNotEmpty) {
      userPosition = await Helpers.getUserLocation();
    }

    final List<HomeCleanupTaskEntity> currentCleanupEntities = [];
    for (final HomeCurrentCleanupTaskModel item in currentCleanups) {
      String distance = 'Distance unavailable';
      if (userPosition != null && item.latitude != 0 && item.longitude != 0) {
        distance = Helpers.formatDistanceFromLatLng(
          startLatitude: userPosition.latitude,
          startLongitude: userPosition.longitude,
          targetLatitude: item.latitude,
          targetLongitude: item.longitude,
        );
      }

      currentCleanupEntities.add(
        HomeCleanupTaskEntity(
          taskId: item.taskId,
          title: item.address,
          subTitle: '',
          distance: distance,
          wasteType: item.wasteType,
          status: 'In Progress',
          timeAgo: Helpers.formatTakenTimeAgo(item.timeAgo),
          imageUrl: item.imageUrl.isNotEmpty
              ? item.imageUrl
              : 'https://images.pexels.com/photos/3735657/pexels-photo-3735657.jpeg?auto=compress&cs=tinysrgb&w=600',
          imageUrls: item.imageUrls,
          latitude: item.latitude,
          longitude: item.longitude,
          locationQuery: item.address.trim().isNotEmpty
              ? item.address
              : '${item.latitude},${item.longitude}',
        ),
      );
    }

    final HomeCleanupTaskEntity firstCleanup = currentCleanupEntities.isNotEmpty
        ? currentCleanupEntities.first
        : const HomeCleanupTaskEntity(
            taskId: 0,
            title: 'No Active Cleanup',
            subTitle: '',
            distance: 'Distance unavailable',
            wasteType: 'Unknown',
            status: 'In Progress',
            timeAgo: 'Taken recently',
            imageUrl:
                'https://images.pexels.com/photos/3735657/pexels-photo-3735657.jpeg?auto=compress&cs=tinysrgb&w=600',
          );

    return HomeDashboardEntity(
      workerName: 'Ahmed',
      avgHours: overview.averageHours,
      completedCount: overview.completedCleanupsCount,
      currentCleanup: firstCleanup,
      currentCleanups: currentCleanupEntities,
      nearbyReports: [
        const HomeNearbyReportEntity(
          id: 0,
          title: 'Al Wahda Street, near',
          distance: '0.8 km',
          timeAgo: '2 hours ago',
          wasteType: 'Plastic Bottles',
          imageUrl:
              'https://images.pexels.com/photos/3735657/pexels-photo-3735657.jpeg?auto=compress&cs=tinysrgb&w=600',
        ),
        const HomeNearbyReportEntity(
          id: 0,
          title: 'Khalifa Park, East Entrance',
          distance: '1.2 km',
          timeAgo: '3 hours ago',
          wasteType: 'Mixed Waste',
          imageUrl:
              'https://images.pexels.com/photos/48195/document-agreement-documents-sign-48195.jpeg?auto=compress&cs=tinysrgb&w=600',
        ),
        const HomeNearbyReportEntity(
          id: 0,
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
