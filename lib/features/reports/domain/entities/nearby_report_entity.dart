class NearbyReportEntity {
  final int id;
  final double latitude;
  final double longitude;
  final String address;
  final int wasteType;
  final String createdAt;
  final String imageUrl;
  final List<String> imageUrls;

  const NearbyReportEntity({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.wasteType,
    required this.createdAt,
    required this.imageUrl,
    this.imageUrls = const <String>[],
  });
}
