import 'package:yallakhadra/features/profile/domain/entities/change_password_entity.dart';

class ChangePasswordModel {
  final int statusCode;
  final bool succeeded;
  final String message;
  final List<String> errors;

  const ChangePasswordModel({
    required this.statusCode,
    required this.succeeded,
    required this.message,
    required this.errors,
  });

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    final dynamic errorsRaw = json['errors'] ?? json['Errors'];

    final List<String> parsedErrors = errorsRaw is List<dynamic>
        ? errorsRaw
              .whereType<String>()
              .map((String item) => item.trim())
              .where((String item) => item.isNotEmpty)
              .toList(growable: false)
        : <String>[];

    return ChangePasswordModel(
      statusCode:
          (json['statusCode'] as num?)?.toInt() ??
          (json['StatusCode'] as num?)?.toInt() ??
          0,
      succeeded:
          (json['succeeded'] as bool?) ?? (json['Succeeded'] as bool?) ?? false,
      message:
          (json['message'] as String?)?.trim() ??
          (json['Message'] as String?)?.trim() ??
          '',
      errors: parsedErrors,
    );
  }

  ChangePasswordEntity toEntity() {
    return ChangePasswordEntity(
      statusCode: statusCode,
      succeeded: succeeded,
      message: message,
      errors: errors,
    );
  }
}
