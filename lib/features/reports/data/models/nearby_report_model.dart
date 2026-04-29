import 'package:yallakhadra/features/reports/domain/entities/nearby_report_entity.dart';

class NearbyReportModel {
  final int id;
  final double latitude;
  final double longitude;
  final String address;
  final int wasteType;
  final String createdAt;
  final String imageUrl;
  final List<String> imageUrls;

  const NearbyReportModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.wasteType,
    required this.createdAt,
    required this.imageUrl,
    required this.imageUrls,
  });

  factory NearbyReportModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> images =
        (json['images'] as List<dynamic>?) ?? <dynamic>[];
    final List<String> allImageUrls = images
        .whereType<Map<String, dynamic>>()
        .map((Map<String, dynamic> image) => (image['url'] as String?) ?? '')
        .where((String url) => url.trim().isNotEmpty)
        .toList();
    final String firstImageUrl = images.isNotEmpty
        ? (images.first as Map<String, dynamic>)['url'] as String? ?? ''
        : '';

    return NearbyReportModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      address: (json['address'] as String?) ?? '',
      wasteType: (json['wasteType'] as num?)?.toInt() ?? 0,
      createdAt: (json['createdAt'] as String?) ?? '',
      imageUrl: firstImageUrl,
      imageUrls: allImageUrls,
    );
  }

  NearbyReportEntity toEntity() {
    return NearbyReportEntity(
      id: id,
      latitude: latitude,
      longitude: longitude,
      address: address,
      wasteType: wasteType,
      createdAt: createdAt,
      imageUrl: imageUrl,
      imageUrls: imageUrls,
    );
  }
}
