class HomeMainOverviewModel {
  final int completedCleanupsCount;
  final int averageHours;

  const HomeMainOverviewModel({
    required this.completedCleanupsCount,
    required this.averageHours,
  });

  factory HomeMainOverviewModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data =
        (json['data'] as Map<String, dynamic>?) ?? <String, dynamic>{};

    return HomeMainOverviewModel(
      completedCleanupsCount:
          (data['completedCleanupsCount'] as num?)?.toInt() ?? 0,
      averageHours: (data['averageHours'] as num?)?.toInt() ?? 0,
    );
  }

  static String extractFailureMessage(
    Map<String, dynamic> json, {
    String fallback = 'Unable to load home overview.',
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
