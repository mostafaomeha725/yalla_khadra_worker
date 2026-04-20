import 'package:equatable/equatable.dart';

class ChangePasswordEntity extends Equatable {
  final int statusCode;
  final bool succeeded;
  final String message;
  final List<String> errors;

  const ChangePasswordEntity({
    required this.statusCode,
    required this.succeeded,
    required this.message,
    required this.errors,
  });

  @override
  List<Object?> get props => <Object?>[statusCode, succeeded, message, errors];
}
