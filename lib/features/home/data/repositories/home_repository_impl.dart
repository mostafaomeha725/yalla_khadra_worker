import 'package:yallakhadra/core/di/services_locator.dart';
import 'package:yallakhadra/core/network/network_service.dart';
import 'package:yallakhadra/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:yallakhadra/features/home/data/data_sources/home_remote_data_source_impl.dart';
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
    final HomeMainOverviewModel overview = overviewResult.fold(
      (failure) => throw Exception(failure.message),
      (model) => model,
    );

    return HomeDashboardEntity(
      workerName: 'Ahmed',
      avgHours: overview.averageHours,
      completedCount: overview.completedCleanupsCount,
      currentCleanup: const HomeCleanupTaskEntity(
        title: 'Al Wahda Street, near',
        subTitle: 'City Mall',
        distance: '0.8 km away',
        wasteType: 'Plastic Bottles',
        status: 'In Progress',
        timeAgo: 'Taken 1 hour ago',
        imageUrl:
            'https://images.pexels.com/photos/3735657/pexels-photo-3735657.jpeg?auto=compress&cs=tinysrgb&w=600',
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
}
