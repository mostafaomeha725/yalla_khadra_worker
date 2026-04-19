import 'package:yallakhadra/features/home/domain/entities/home_cleanup_task_entity.dart';
import 'package:yallakhadra/features/home/domain/entities/home_dashboard_entity.dart';
import 'package:yallakhadra/features/home/domain/entities/home_nearby_report_entity.dart';
import 'package:yallakhadra/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<HomeDashboardEntity> getHomeDashboard() async {
    return const HomeDashboardEntity(
      workerName: 'Ahmed',
      avgMinutes: 45,
      completedCount: 850,
      currentCleanup: HomeCleanupTaskEntity(
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
        HomeNearbyReportEntity(
          title: 'Al Wahda Street, near',
          distance: '0.8 km',
          timeAgo: '2 hours ago',
          wasteType: 'Plastic Bottles',
          imageUrl:
              'https://images.pexels.com/photos/3735657/pexels-photo-3735657.jpeg?auto=compress&cs=tinysrgb&w=600',
        ),
        HomeNearbyReportEntity(
          title: 'Khalifa Park, East Entrance',
          distance: '1.2 km',
          timeAgo: '3 hours ago',
          wasteType: 'Mixed Waste',
          imageUrl:
              'https://images.pexels.com/photos/48195/document-agreement-documents-sign-48195.jpeg?auto=compress&cs=tinysrgb&w=600',
        ),
        HomeNearbyReportEntity(
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
