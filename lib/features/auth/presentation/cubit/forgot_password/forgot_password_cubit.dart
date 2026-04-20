import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/core/utils/validators.dart';
import 'package:yallakhadra/features/auth/domain/usecases/confirm_password_reset_usecase.dart';
import 'package:yallakhadra/features/auth/domain/usecases/request_password_reset_usecase.dart';
import 'package:yallakhadra/features/auth/domain/usecases/verify_password_reset_code_usecase.dart';
import 'package:yallakhadra/features/auth/presentation/cubit/forgot_password/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final RequestPasswordResetUseCase _requestPasswordResetUseCase;
  final VerifyPasswordResetCodeUseCase _verifyPasswordResetCodeUseCase;
  final ConfirmPasswordResetUseCase _confirmPasswordResetUseCase;
  ForgotPasswordCubit(
    this._requestPasswordResetUseCase,
    this._verifyPasswordResetCodeUseCase,
    this._confirmPasswordResetUseCase,
  ) : super(const ForgotPasswordInitial());

  Future<void> requestPasswordReset({required String email}) async {
    final String? validationError = Validators.validateForgotPasswordEmail(
      email,
    );

    if (validationError != null) {
      emit(ForgotPasswordError(validationError));
      return;
    }

    emit(const ForgotPasswordLoading());

    try {
      final result = await _requestPasswordResetUseCase(
        RequestPasswordResetParams(email: email),
      );

      result.fold(
        (failure) => emit(ForgotPasswordError(failure.message)),
        (message) => emit(ForgotPasswordSuccess(message)),
      );
    } catch (_) {
      const String message = 'Unable to send password reset email right now.';
      emit(const ForgotPasswordError(message));
    }
  }

  Future<void> verifyCode({required String email, required String code}) async {
    final String? emailValidationError = Validators.validateForgotPasswordEmail(
      email,
    );
    if (emailValidationError != null) {
      emit(ForgotPasswordError(emailValidationError));
      return;
    }

    final String? codeValidationError = Validators.validateOtpCode(code);
    if (codeValidationError != null) {
      emit(ForgotPasswordError(codeValidationError));
      return;
    }

    emit(const ForgotPasswordLoading());

    try {
      final result = await _verifyPasswordResetCodeUseCase(
        VerifyPasswordResetCodeParams(email: email, code: code),
      );

      result.fold((failure) => emit(ForgotPasswordError(failure.message)), (
        isValid,
      ) {
        if (!isValid) {
          emit(const ForgotPasswordError('Invalid verification code.'));
          return;
        }

        emit(
          ForgotPasswordCodeVerified(
            message: 'Code verified successfully.',
            email: email,
            code: code,
          ),
        );
      });
    } catch (_) {
      const String message = 'Unable to verify code right now.';
      emit(const ForgotPasswordError(message));
    }
  }

  Future<void> confirmPasswordReset({
    required String email,
    required String code,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    final String? emailValidationError = Validators.validateForgotPasswordEmail(
      email,
    );
    if (emailValidationError != null) {
      emit(ForgotPasswordError(emailValidationError));
      return;
    }

    final String? codeValidationError = Validators.validateOtpCode(code);
    if (codeValidationError != null) {
      emit(ForgotPasswordError(codeValidationError));
      return;
    }

    final String? passwordValidationError =
        Validators.validateProfileChangePasswordCredentials(
          currentPassword: '_',
          newPassword: newPassword,
          confirmPassword: confirmNewPassword,
        );
    if (passwordValidationError != null) {
      emit(ForgotPasswordError(passwordValidationError));
      return;
    }

    emit(const ForgotPasswordLoading());

    try {
      final result = await _confirmPasswordResetUseCase(
        ConfirmPasswordResetParams(
          email: email,
          code: code,
          newPassword: newPassword,
          confirmNewPassword: confirmNewPassword,
        ),
      );

      result.fold(
        (failure) => emit(ForgotPasswordError(failure.message)),
        (message) => emit(ForgotPasswordResetConfirmed(message)),
      );
    } catch (_) {
      const String message = 'Unable to reset password right now.';
      emit(const ForgotPasswordError(message));
    }
  }
}
