import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/core/usecase/base_usecase.dart';
import 'package:yallakhadra/features/profile/domain/usecases/logout_usecase.dart';
import 'package:yallakhadra/features/profile/presentation/cubit/profile_logout_state.dart';

class ProfileLogoutCubit extends Cubit<ProfileLogoutState> {
  final LogoutUseCase _logoutUseCase;

  ProfileLogoutCubit(this._logoutUseCase) : super(const ProfileLogoutInitial());

  Future<void> logout() async {
    emit(const ProfileLogoutLoading());

    try {
      final result = await _logoutUseCase(NoParams());
      result.fold(
        (failure) => emit(ProfileLogoutError(failure.message)),
        (message) => emit(ProfileLogoutSuccess(message)),
      );
    } catch (_) {
      emit(const ProfileLogoutError('Unable to logout right now.'));
    }
  }
}
