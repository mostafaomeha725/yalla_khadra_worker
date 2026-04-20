import 'package:equatable/equatable.dart';
import 'package:yallakhadra/features/auth/domain/entities/auth_entity.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => <Object?>[];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final AuthEntity auth;

  const LoginSuccess(this.auth);

  @override
  List<Object?> get props => <Object?>[auth];
}

class LoginError extends LoginState {
  final String message;

  const LoginError(this.message);

  @override
  List<Object?> get props => <Object?>[message];
}
