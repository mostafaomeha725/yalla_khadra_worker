import 'package:yallakhadra/features/my_works/domain/entities/my_work_report_entity.dart';

class MyWorkReportsPageEntity {
  final List<MyWorkReportEntity> reports;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final int pageSize;
  final bool hasPreviousPage;
  final bool hasNextPage;

  const MyWorkReportsPageEntity({
    required this.reports,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.pageSize,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });
}
