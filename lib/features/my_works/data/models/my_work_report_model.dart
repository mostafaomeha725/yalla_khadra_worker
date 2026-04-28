import 'package:yallakhadra/features/my_works/domain/entities/my_work_report_entity.dart';

class MyWorkReportModel {
  final int reportId;
  final String firstImageUrl;
  final String address;
  final String completedAt;
  final String duration;

  const MyWorkReportModel({
    required this.reportId,
    required this.firstImageUrl,
    required this.address,
    required this.completedAt,
    required this.duration,
  });

  factory MyWorkReportModel.fromJson(Map<String, dynamic> json) {
    return MyWorkReportModel(
      reportId: (json['reportId'] as num?)?.toInt() ?? 0,
      firstImageUrl: (json['firstImageUrl'] as String?) ?? '',
      address: (json['address'] as String?) ?? '',
      completedAt: (json['completedAt'] as String?) ?? '',
      duration: (json['duration'] as String?) ?? '',
    );
  }

  MyWorkReportEntity toEntity() {
    return MyWorkReportEntity(
      reportId: reportId,
      firstImageUrl: firstImageUrl,
      address: address,
      completedAt: completedAt,
      duration: duration,
    );
  }
}
