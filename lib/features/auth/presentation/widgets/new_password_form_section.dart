import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yallakhadra/core/routes/route_paths.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/easy_loading.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_button.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/auth/presentation/constants/auth_strings.dart';
import 'package:yallakhadra/features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:yallakhadra/features/auth/presentation/cubit/forgot_password/forgot_password_state.dart';
import 'package:yallakhadra/features/auth/presentation/widgets/new_password_input_field.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/new_password_validation_steps.dart';

class NewPasswordFormSection extends StatefulWidget {
  const NewPasswordFormSection({
    required this.email,
    required this.code,
    super.key,
  });

  final String email;
  final String code;

  @override
  State<NewPasswordFormSection> createState() => NewPasswordFormSectionState();
}

class NewPasswordFormSectionState extends State<NewPasswordFormSection> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (BuildContext context, ForgotPasswordState state) {
        if (state is ForgotPasswordLoading) {
          showLoading(status: 'Resetting password...', userInteractions: false);
        } else if (state is ForgotPasswordError) {
          hideLoading();
          showError(state.message);
        } else if (state is ForgotPasswordResetConfirmed) {
          hideLoading();
          showSuccess(state.message);
          context.go(Routes.loginScreen);
        }
      },
      builder: (BuildContext context, ForgotPasswordState state) {
        final bool isLoading = state is ForgotPasswordLoading;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppText(
              AuthStrings.newPasswordLabel,
              style: font14w500.copyWith(color: AppColors.authLabel),
            ),
            verticalSpacing(8),
            NewPasswordInputField(
              controller: newPasswordController,
              hintText: AuthStrings.newPasswordHint,
            ),
            verticalSpacing(10),
            NewPasswordValidationSteps(controller: newPasswordController),
            verticalSpacing(14),
            AppText(
              AuthStrings.confirmPasswordLabel,
              style: font14w500.copyWith(color: AppColors.authLabel),
            ),
            verticalSpacing(8),
            NewPasswordInputField(
              controller: confirmPasswordController,
              hintText: AuthStrings.confirmPasswordHint,
            ),
            verticalSpacing(20),
            Stack(
              alignment: AlignmentDirectional.centerStart,
              children: [
                AppButton(
                  text: AuthStrings.changePasswordButton,
                  onPressed: isLoading
                      ? null
                      : () {
                          context
                              .read<ForgotPasswordCubit>()
                              .confirmPasswordReset(
                                email: widget.email,
                                code: widget.code,
                                newPassword: newPasswordController.text.trim(),
                                confirmNewPassword: confirmPasswordController
                                    .text
                                    .trim(),
                              );
                        },
                  color: AppColors.authPrimary,
                  textColor: Colors.white,
                  textSize: 16.sp,
                  textWeight: FontWeight.w600,
                  radius: 14.r,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 16.w),
                  child: IgnorePointer(
                    child: Icon(
                      Icons.check_circle_outline_rounded,
                      size: 18.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
