import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/core/utils/validators.dart';
import 'package:yallakhadra/features/auth/domain/usecases/auth_usecase.dart';
import 'package:yallakhadra/features/auth/presentation/cubit/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthUseCase _authUseCase;

  LoginCubit(this._authUseCase) : super(const LoginInitial());

  Future<void> login({required String email, required String password}) async {
    final String? validationError = Validators.validateLoginCredentials(
      email: email,
      password: password,
    );

    if (validationError != null) {
      emit(LoginError(validationError));
      return;
    }

    emit(const LoginLoading());

    try {
      final result = await _authUseCase(
        AuthParams(email: email, password: password),
      );

      result.fold(
        (failure) => emit(LoginError(failure.message)),
        (auth) => emit(LoginSuccess(auth)),
      );
    } catch (_) {
      const String message = 'Unexpected login error';
      emit(const LoginError(message));
    }
  }
}
