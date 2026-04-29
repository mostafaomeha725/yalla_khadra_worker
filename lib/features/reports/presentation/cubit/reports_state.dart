import 'package:yallakhadra/features/reports/domain/entities/nearby_reports_page_entity.dart';

abstract class ReportsState {
  const ReportsState();
}

class ReportsInitial extends ReportsState {
  const ReportsInitial();
}

class ReportsLoading extends ReportsState {
  const ReportsLoading();
}

class ReportsLoaded extends ReportsState {
  final NearbyReportsPageEntity page;
  final double? radiusInKm;

  const ReportsLoaded({required this.page, required this.radiusInKm});
}

class ReportsError extends ReportsState {
  final String message;

  const ReportsError(this.message);
}
