import 'package:yallakhadra/features/home/domain/entities/home_dashboard_entity.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final HomeDashboardEntity dashboard;

  const HomeLoaded(this.dashboard);
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}
