import 'package:yallakhadra/features/home/domain/entities/home_dashboard_entity.dart';

abstract class HomeRepository {
  Future<HomeDashboardEntity> getHomeDashboard();
}
