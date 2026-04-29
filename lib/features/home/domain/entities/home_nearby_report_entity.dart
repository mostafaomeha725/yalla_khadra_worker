class HomeNearbyReportEntity {
  final String title;
  final String distance;
  final String timeAgo;
  final String wasteType;
  final String imageUrl;
  final List<String> imageUrls;

  const HomeNearbyReportEntity({
    required this.title,
    required this.distance,
    required this.timeAgo,
    required this.wasteType,
    required this.imageUrl,
    this.imageUrls = const <String>[],
  });
}
