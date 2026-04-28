import 'package:yallakhadra/features/my_works/domain/entities/my_work_overview_entity.dart';
import 'package:yallakhadra/features/my_works/domain/entities/my_work_reports_page_entity.dart';

abstract class MyWorkOverviewState {
  const MyWorkOverviewState();
}

class MyWorkOverviewInitial extends MyWorkOverviewState {
  const MyWorkOverviewInitial();
}

class MyWorkOverviewLoading extends MyWorkOverviewState {
  const MyWorkOverviewLoading();
}

class MyWorkOverviewLoaded extends MyWorkOverviewState {
  final MyWorkOverviewEntity overview;
  final MyWorkReportsPageEntity reportsPage;

  const MyWorkOverviewLoaded(this.overview, this.reportsPage);
}

class MyWorkOverviewError extends MyWorkOverviewState {
  final String message;

  const MyWorkOverviewError(this.message);
}
