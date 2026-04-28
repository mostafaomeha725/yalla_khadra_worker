class MyWorkReportEntity {
  final int reportId;
  final String firstImageUrl;
  final String address;
  final String completedAt;
  final String duration;

  const MyWorkReportEntity({
    required this.reportId,
    required this.firstImageUrl,
    required this.address,
    required this.completedAt,
    required this.duration,
  });
}
