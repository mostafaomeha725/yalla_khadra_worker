import 'package:equatable/equatable.dart';

class AiScanResultEntity extends Equatable {
  final int id;
  final int userId;
  final String userName;
  final String predictedType;
  final bool isRecyclable;
  final String explanation;
  final String createdAt;
  final String imageUrl;

  const AiScanResultEntity({
    required this.id,
    required this.userId,
    required this.userName,
    required this.predictedType,
    required this.isRecyclable,
    required this.explanation,
    required this.createdAt,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => <Object?>[
    id,
    userId,
    userName,
    predictedType,
    isRecyclable,
    explanation,
    createdAt,
    imageUrl,
  ];
}
