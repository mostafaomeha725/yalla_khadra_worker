class HomeCleanupTaskEntity {
  final String title;
  final String subTitle;
  final String distance;
  final String wasteType;
  final String status;
  final String timeAgo;
  final String imageUrl;

  const HomeCleanupTaskEntity({
    required this.title,
    required this.subTitle,
    required this.distance,
    required this.wasteType,
    required this.status,
    required this.timeAgo,
    required this.imageUrl,
  });
}
