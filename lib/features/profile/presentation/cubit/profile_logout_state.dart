import 'package:equatable/equatable.dart';

abstract class ProfileLogoutState extends Equatable {
  const ProfileLogoutState();

  @override
  List<Object?> get props => <Object?>[];
}

class ProfileLogoutInitial extends ProfileLogoutState {
  const ProfileLogoutInitial();
}

class ProfileLogoutLoading extends ProfileLogoutState {
  const ProfileLogoutLoading();
}

class ProfileLogoutSuccess extends ProfileLogoutState {
  final String message;

  const ProfileLogoutSuccess(this.message);

  @override
  List<Object?> get props => <Object?>[message];
}

class ProfileLogoutError extends ProfileLogoutState {
  final String message;

  const ProfileLogoutError(this.message);

  @override
  List<Object?> get props => <Object?>[message];
}
