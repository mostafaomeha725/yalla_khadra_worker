import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';

Either<Failure, String> parseMessageResponse({
  required dynamic data,
  required String defaultFailure,
  required String defaultSuccess,
}) {
  if (data is! Map<String, dynamic>) {
    return const Left(ServerFailure(message: 'Invalid server response'));
  }

  final bool succeeded =
      (data['succeeded'] as bool?) ?? (data['Succeeded'] as bool?) ?? false;
  final List<dynamic> errors =
      (data['errors'] as List<dynamic>?) ??
      (data['Errors'] as List<dynamic>?) ??
      const <dynamic>[];
  final String message =
      (data['message'] as String?) ?? (data['Message'] as String?) ?? '';

  if (!succeeded) {
    final String errorMessage = errors.whereType<String>().firstWhere(
      (String item) => item.trim().isNotEmpty,
      orElse: () => message,
    );
    final String fallbackMessage = errorMessage.trim().isEmpty
        ? defaultFailure
        : errorMessage;
    return Left(ServerFailure(message: fallbackMessage));
  }

  final String successMessage = message.trim().isEmpty
      ? defaultSuccess
      : message;
  return Right(successMessage);
}

Either<Failure, bool> parseVerifyCodeResponse({
  required dynamic data,
  required String defaultFailure,
}) {
  if (data is! Map<String, dynamic>) {
    return const Left(ServerFailure(message: 'Invalid server response'));
  }

  final bool succeeded =
      (data['succeeded'] as bool?) ?? (data['Succeeded'] as bool?) ?? false;
  final List<dynamic> errors =
      (data['errors'] as List<dynamic>?) ??
      (data['Errors'] as List<dynamic>?) ??
      const <dynamic>[];
  final String message =
      (data['message'] as String?) ?? (data['Message'] as String?) ?? '';

  if (!succeeded) {
    final String errorMessage = errors.whereType<String>().firstWhere(
      (String item) => item.trim().isNotEmpty,
      orElse: () => message,
    );
    final String fallbackMessage = errorMessage.trim().isEmpty
        ? defaultFailure
        : errorMessage;
    return Left(ServerFailure(message: fallbackMessage));
  }

  final Map<String, dynamic> payload =
      (data['data'] as Map<String, dynamic>?) ??
      (data['Data'] as Map<String, dynamic>?) ??
      const <String, dynamic>{};
  return Right(payload['isValid'] as bool? ?? false);
}

Left<Failure, T> parseFailureResponse<T>({
  required Failure failure,
  required String defaultFailure,
}) {
  final String message = failure.message.trim();
  if (message.isEmpty || message.toLowerCase() == 'request failed') {
    return Left(ServerFailure(message: defaultFailure));
  }
  return Left(ServerFailure(message: message));
}
