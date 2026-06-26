import 'package:yallakhadra/features/my_works/domain/entities/my_work_details_entity.dart';

class MyWorkDetailsImageModel extends MyWorkDetailsImageEntity {
  const MyWorkDetailsImageModel({
    required super.id,
    required super.url,
    required super.uploadedAt,
  });

  factory MyWorkDetailsImageModel.fromJson(Map<String, dynamic> json) {
    return MyWorkDetailsImageModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      url: json['url'] as String? ?? '',
      uploadedAt: json['uploadedAt'] as String? ?? '',
    );
  }

  MyWorkDetailsImageEntity toEntity() {
    return MyWorkDetailsImageEntity(
      id: id,
      url: url,
      uploadedAt: uploadedAt,
    );
  }
}

class MyWorkDetailsModel extends MyWorkDetailsEntity {
  const MyWorkDetailsModel({
    required super.id,
    required super.latitude,
    required super.longitude,
    required super.address,
    required super.status,
    required super.wasteType,
    required super.createdAt,
    required super.userId,
    required super.userName,
    required super.images,
    required super.finalWasteType,
    required super.finalWasteTypeName,
    required super.finalWeightInKg,
    required super.cleanupImages,
  });

  factory MyWorkDetailsModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = json['data'] ?? <String, dynamic>{};

    final List<dynamic> imagesJson = data['images'] ?? [];
    final List<MyWorkDetailsImageModel> parsedImages =
        imagesJson.map((img) => MyWorkDetailsImageModel.fromJson(img)).toList();

    final List<dynamic> cleanupImagesJson = data['cleanupImages'] ?? [];
    final List<MyWorkDetailsImageModel> parsedCleanupImages = cleanupImagesJson
        .map((img) => MyWorkDetailsImageModel.fromJson(img))
        .toList();

    return MyWorkDetailsModel(
      id: (data['id'] as num?)?.toInt() ?? 0,
      latitude: (data['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (data['longitude'] as num?)?.toDouble() ?? 0.0,
      address: data['address'] as String? ?? '',
      status: (data['status'] as num?)?.toInt() ?? 0,
      wasteType: (data['wasteType'] as num?)?.toInt() ?? 0,
      createdAt: data['createdAt'] as String? ?? '',
      userId: (data['userId'] as num?)?.toInt() ?? 0,
      userName: data['userName'] as String? ?? '',
      images: parsedImages,
      finalWasteType: (data['finalWasteType'] as num?)?.toInt() ?? 0,
      finalWasteTypeName: data['finalWasteTypeName'] as String? ?? '',
      finalWeightInKg: (data['finalWeightInKg'] as num?)?.toDouble() ?? 0.0,
      cleanupImages: parsedCleanupImages,
    );
  }

  MyWorkDetailsEntity toEntity() {
    return MyWorkDetailsEntity(
      id: id,
      latitude: latitude,
      longitude: longitude,
      address: address,
      status: status,
      wasteType: wasteType,
      createdAt: createdAt,
      userId: userId,
      userName: userName,
      images: images.map((m) => (m as MyWorkDetailsImageModel).toEntity()).toList(),
      finalWasteType: finalWasteType,
      finalWasteTypeName: finalWasteTypeName,
      finalWeightInKg: finalWeightInKg,
      cleanupImages: cleanupImages.map((m) => (m as MyWorkDetailsImageModel).toEntity()).toList(),
    );
  }
}
