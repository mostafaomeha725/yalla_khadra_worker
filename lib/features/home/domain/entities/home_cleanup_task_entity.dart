class HomeCleanupTaskEntity {
  final int taskId;
  final String title;
  final String subTitle;
  final String distance;
  final String wasteType;
  final String status;
  final String timeAgo;
  final String imageUrl;
  final List<String> imageUrls;
  final double latitude;
  final double longitude;
  final String locationQuery;

  const HomeCleanupTaskEntity({
    this.taskId = 0,
    required this.title,
    required this.subTitle,
    required this.distance,
    required this.wasteType,
    required this.status,
    required this.timeAgo,
    required this.imageUrl,
    this.imageUrls = const <String>[],
    this.latitude = 0,
    this.longitude = 0,
    this.locationQuery = '',
  });
}
