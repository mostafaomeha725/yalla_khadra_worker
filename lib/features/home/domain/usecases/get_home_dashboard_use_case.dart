import 'package:yallakhadra/features/home/domain/entities/home_dashboard_entity.dart';
import 'package:yallakhadra/features/home/domain/repositories/home_repository.dart';

class GetHomeDashboardUseCase {
  final HomeRepository repository;

  const GetHomeDashboardUseCase(this.repository);

  Future<HomeDashboardEntity> call() {
    return repository.getHomeDashboard();
  }
}
