import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/features/ai_scan/domain/entities/ai_scan_result_entity.dart';

class AiScanResultModel {
  final AiScanResultEntity result;
  final String message;

  const AiScanResultModel({required this.result, required this.message});

  factory AiScanResultModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data =
        (json['data'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final Map<String, dynamic> image =
        (data['wasteScanImage'] as Map<String, dynamic>?) ??
        <String, dynamic>{};

    return AiScanResultModel(
      result: AiScanResultEntity(
        id: (data['id'] as num?)?.toInt() ?? 0,
        userId: (data['userId'] as num?)?.toInt() ?? 0,
        userName: data['userName'] as String? ?? '',
        predictedType: data['aiPredictedType'] as String? ?? '',
        isRecyclable: data['aiIsRecyclable'] as bool? ?? false,
        explanation: data['aiExplanation'] as String? ?? '',
        createdAt: data['createdAt'] as String? ?? '',
        imageUrl: image['url'] as String? ?? '',
      ),
      message: json['message'] as String? ?? 'Created successfully.',
    );
  }

  static ServerFailure parseResponseFailure(Map<String, dynamic> json) {
    final dynamic errors = json['errors'] ?? json['Errors'];
    if (errors is Map<String, dynamic>) {
      for (final dynamic value in errors.values) {
        if (value is List<dynamic>) {
          for (final dynamic item in value) {
            if (item is String && item.trim().isNotEmpty) {
              return ServerFailure(message: item);
            }
          }
        }
      }
    }

    if (errors is List<dynamic>) {
      for (final dynamic item in errors) {
        if (item is String && item.trim().isNotEmpty) {
          return ServerFailure(message: item);
        }
      }
    }

    final String message =
        (json['message'] as String?) ??
        (json['Message'] as String?) ??
        (json['title'] as String?) ??
        'Unable to analyze image.';
    return ServerFailure(message: message);
  }
}
