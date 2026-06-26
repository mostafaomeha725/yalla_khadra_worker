import 'package:equatable/equatable.dart';

class MyWorkDetailsImageEntity extends Equatable {
  final int id;
  final String url;
  final String uploadedAt;

  const MyWorkDetailsImageEntity({
    required this.id,
    required this.url,
    required this.uploadedAt,
  });

  @override
  List<Object?> get props => [id, url, uploadedAt];
}

class MyWorkDetailsEntity extends Equatable {
  final int id;
  final double latitude;
  final double longitude;
  final String address;
  final int status;
  final int wasteType;
  final String createdAt;
  final int userId;
  final String userName;
  final List<MyWorkDetailsImageEntity> images;
  final int finalWasteType;
  final String finalWasteTypeName;
  final double finalWeightInKg;
  final List<MyWorkDetailsImageEntity> cleanupImages;

  const MyWorkDetailsEntity({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.status,
    required this.wasteType,
    required this.createdAt,
    required this.userId,
    required this.userName,
    required this.images,
    required this.finalWasteType,
    required this.finalWasteTypeName,
    required this.finalWeightInKg,
    required this.cleanupImages,
  });

  @override
  List<Object?> get props => [
        id,
        latitude,
        longitude,
        address,
        status,
        wasteType,
        createdAt,
        userId,
        userName,
        images,
        finalWasteType,
        finalWasteTypeName,
        finalWeightInKg,
        cleanupImages,
      ];
}
