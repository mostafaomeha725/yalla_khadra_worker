import 'package:yallakhadra/features/reports/data/models/nearby_report_model.dart';
import 'package:yallakhadra/features/reports/domain/entities/nearby_reports_page_entity.dart';

class NearbyReportsPageModel {
  final List<NearbyReportModel> reports;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final int pageSize;
  final bool hasPreviousPage;
  final bool hasNextPage;

  const NearbyReportsPageModel({
    required this.reports,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.pageSize,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory NearbyReportsPageModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList =
        (json['data'] as List<dynamic>?) ?? <dynamic>[];

    return NearbyReportsPageModel(
      reports: dataList
          .whereType<Map<String, dynamic>>()
          .map(NearbyReportModel.fromJson)
          .toList(),
      currentPage: (json['currentPage'] as num?)?.toInt() ?? 1,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 1,
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
      hasPreviousPage: (json['hasPreviousPage'] as bool?) ?? false,
      hasNextPage: (json['hasNextPage'] as bool?) ?? false,
    );
  }

  NearbyReportsPageEntity toEntity() {
    return NearbyReportsPageEntity(
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
