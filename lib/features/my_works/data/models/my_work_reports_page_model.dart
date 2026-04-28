import 'package:yallakhadra/features/my_works/data/models/my_work_report_model.dart';
import 'package:yallakhadra/features/my_works/domain/entities/my_work_reports_page_entity.dart';

class MyWorkReportsPageModel {
  final List<MyWorkReportModel> reports;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final int pageSize;
  final bool hasPreviousPage;
  final bool hasNextPage;

  const MyWorkReportsPageModel({
    required this.reports,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.pageSize,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory MyWorkReportsPageModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList =
        (json['data'] as List<dynamic>?) ?? <dynamic>[];

    return MyWorkReportsPageModel(
      reports: dataList
          .whereType<Map<String, dynamic>>()
          .map(MyWorkReportModel.fromJson)
          .toList(),
      currentPage: (json['currentPage'] as num?)?.toInt() ?? 1,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 1,
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
      hasPreviousPage: (json['hasPreviousPage'] as bool?) ?? false,
      hasNextPage: (json['hasNextPage'] as bool?) ?? false,
    );
  }

  MyWorkReportsPageEntity toEntity() {
    return MyWorkReportsPageEntity(
      reports: reports.map((report) => report.toEntity()).toList(),
      currentPage: currentPage,
      totalPages: totalPages,
      totalCount: totalCount,
      pageSize: pageSize,
      hasPreviousPage: hasPreviousPage,
      hasNextPage: hasNextPage,
    );
  }
}
