import 'package:equatable/equatable.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object?> get props => <Object?>[];
}

class ForgotPasswordInitial extends ForgotPasswordState {
  const ForgotPasswordInitial();
}

class ForgotPasswordLoading extends ForgotPasswordState {
  const ForgotPasswordLoading();
}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String message;

  const ForgotPasswordSuccess(this.message);

  @override
  List<Object?> get props => <Object?>[message];
}

class ForgotPasswordCodeVerified extends ForgotPasswordState {
  final String message;
  final String email;
  final String code;

  const ForgotPasswordCodeVerified({
    required this.message,
    required this.email,
    required this.code,
  });

  @override
  List<Object?> get props => <Object?>[message, email, code];
}

class ForgotPasswordResetConfirmed extends ForgotPasswordState {
  final String message;

  const ForgotPasswordResetConfirmed(this.message);

  @override
  List<Object?> get props => <Object?>[message];
}

class ForgotPasswordError extends ForgotPasswordState {
  final String message;

  const ForgotPasswordError(this.message);

  @override
  List<Object?> get props => <Object?>[message];
}
