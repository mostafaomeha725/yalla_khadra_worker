import 'package:yallakhadra/features/my_works/domain/entities/my_work_overview_entity.dart';

class MyWorkOverviewModel {
  final int completedCleanupsCount;
  final double totalHours;
  final double totalWeightInKg;

  const MyWorkOverviewModel({
    required this.completedCleanupsCount,
    required this.totalHours,
    required this.totalWeightInKg,
  });

  factory MyWorkOverviewModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data =
        (json['data'] as Map<String, dynamic>?) ?? <String, dynamic>{};

    return MyWorkOverviewModel(
      completedCleanupsCount:
          (data['completedCleanupsCount'] as num?)?.toInt() ?? 0,
      totalHours: (data['totalHours'] as num?)?.toDouble() ?? 0,
      totalWeightInKg: (data['totalWeightInKg'] as num?)?.toDouble() ?? 0,
    );
  }

  MyWorkOverviewEntity toEntity() {
    return MyWorkOverviewEntity(
      completedCleanupsCount: completedCleanupsCount,
      totalHours: totalHours,
      totalWeightInKg: totalWeightInKg,
    );
  }

  static String extractFailureMessage(
    Map<String, dynamic> json, {
    String fallback = 'Unable to load work overview.',
  }) {
    final dynamic errors = json['errors'] ?? json['Errors'];

    if (errors is Map<String, dynamic>) {
      for (final dynamic value in errors.values) {
        if (value is List<dynamic>) {
          for (final dynamic item in value) {
            if (item is String && item.trim().isNotEmpty) {
              return item;
            }
          }
        }
      }
    }

    if (errors is List<dynamic>) {
      for (final dynamic item in errors) {
        if (item is String && item.trim().isNotEmpty) {
          return item;
        }
      }
    }

    final String message =
        (json['message'] as String?) ??
        (json['Message'] as String?) ??
        (json['title'] as String?) ??
        fallback;

    return message.trim().isEmpty ? fallback : message;
  }
}
