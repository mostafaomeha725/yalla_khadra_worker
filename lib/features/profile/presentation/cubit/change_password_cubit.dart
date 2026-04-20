import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/core/utils/validators.dart';
import 'package:yallakhadra/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:yallakhadra/features/profile/presentation/cubit/change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordCubit(this._changePasswordUseCase)
    : super(const ChangePasswordInitial());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    final String? validationError =
        Validators.validateProfileChangePasswordCredentials(
          currentPassword: currentPassword,
          newPassword: newPassword,
          confirmPassword: confirmNewPassword,
        );

    if (validationError != null) {
      emit(ChangePasswordError(validationError));
      return;
    }

    emit(const ChangePasswordLoading());

    try {
      final result = await _changePasswordUseCase(
        ChangePasswordParams(
          currentPassword: currentPassword,
          newPassword: newPassword,
          confirmNewPassword: confirmNewPassword,
        ),
      );

      result.fold((failure) => emit(ChangePasswordError(failure.message)), (
        response,
      ) {
        final String successMessage = response.message.trim().isEmpty
            ? 'Password updated successfully.'
            : response.message;
        emit(ChangePasswordSuccess(successMessage));
      });
    } catch (_) {
      const String message = 'Unable to update password right now.';
      emit(const ChangePasswordError(message));
    }
  }
}
