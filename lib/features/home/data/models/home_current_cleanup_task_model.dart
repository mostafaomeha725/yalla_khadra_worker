class HomeCurrentCleanupTaskModel {
  final String address;
  final String wasteType;
  final String imageUrl;
  final List<String> imageUrls;
  final String timeAgo;
  final double latitude;
  final double longitude;

  const HomeCurrentCleanupTaskModel({
    required this.address,
    required this.wasteType,
    required this.imageUrl,
    required this.imageUrls,
    required this.timeAgo,
    required this.latitude,
    required this.longitude,
  });

  factory HomeCurrentCleanupTaskModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> report =
        (json['report'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final List<dynamic> images =
        (report['images'] as List<dynamic>?) ?? <dynamic>[];
    final String imageUrl = images.isNotEmpty
        ? ((images.first as Map<String, dynamic>)['url'] as String?) ?? ''
        : '';
    final List<String> imageUrls = images
        .whereType<Map<String, dynamic>>()
        .map((Map<String, dynamic> image) => (image['url'] as String?) ?? '')
        .where((String url) => url.trim().isNotEmpty)
        .toList();

    final int wasteTypeValue = (report['wasteType'] as num?)?.toInt() ?? 0;

    return HomeCurrentCleanupTaskModel(
      address: (report['address'] as String?) ?? '',
      wasteType: mapWasteTypeName(wasteTypeValue),
      imageUrl: imageUrl,
      imageUrls: imageUrls,
      timeAgo: (json['assignedAt'] as String?) ?? '',
      latitude: (report['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (report['longitude'] as num?)?.toDouble() ?? 0,
    );
  }

  static HomeCurrentCleanupTaskModel? fromResponse(Map<String, dynamic> json) {
    final List<dynamic> data = (json['data'] as List<dynamic>?) ?? <dynamic>[];
    if (data.isEmpty) {
      return null;
    }
    final dynamic first = data.first;
    if (first is! Map<String, dynamic>) {
      return null;
    }
    return HomeCurrentCleanupTaskModel.fromJson(first);
  }

  static String mapWasteTypeName(int value) {
    switch (value) {
      case 1:
        return 'Plastic';
      case 2:
        return 'Paper';
      case 3:
        return 'Glass';
      case 4:
        return 'Metal';
      case 5:
        return 'Organic';
      case 6:
        return 'Electronic';
      case 9:
        return 'Construction';
      case 10:
        return 'Textile';
      case 11:
        return 'Mixed';
      default:
        return 'Unknown';
    }
  }
}
