import 'package:yallakhadra/features/profile/domain/entities/update_profile_entity.dart';

class UpdateProfileModel {
  final bool succeeded;
  final String message;
  final List<String> errors;

  const UpdateProfileModel({
    required this.succeeded,
    required this.message,
    required this.errors,
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    final dynamic rawErrors = json['errors'] ?? json['Errors'];
    return UpdateProfileModel(
      succeeded:
          (json['succeeded'] as bool?) ??
          (json['Succeeded'] as bool?) ??
          (json['statusCode'] as num?) == 200,
      message:
          (json['message'] as String?) ?? (json['Message'] as String?) ?? '',
      errors: rawErrors is List<dynamic>
          ? rawErrors
                .whereType<String>()
                .map((e) => e.trim())
                .where((e) => e.isNotEmpty)
                .toList(growable: false)
          : const <String>[],
    );
  }

  UpdateProfileEntity toEntity() {
    return UpdateProfileEntity(message: message);
  }
}
