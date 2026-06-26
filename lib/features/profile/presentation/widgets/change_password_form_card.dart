import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/easy_loading.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_button.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/profile/presentation/cubit/change_password_cubit.dart';
import 'package:yallakhadra/features/profile/presentation/cubit/change_password_state.dart';
import 'package:yallakhadra/features/profile/presentation/constants/profile_strings.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/new_password_validation_steps.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/profile_password_field.dart';

class ChangePasswordFormCard extends StatefulWidget {
  const ChangePasswordFormCard({super.key});

  @override
  State<ChangePasswordFormCard> createState() => ChangePasswordFormCardState();
}

class ChangePasswordFormCardState extends State<ChangePasswordFormCard> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (BuildContext context, ChangePasswordState state) {
        if (state is ChangePasswordLoading) {
          showLoading(status: 'Updating password...', userInteractions: false);
        }

        if (state is ChangePasswordError) {
          hideLoading();
          showError(state.message);
        }

        if (state is ChangePasswordSuccess) {
          hideLoading();
          showSuccess(state.message);
          currentPasswordController.clear();
          newPasswordController.clear();
          confirmPasswordController.clear();
        }
      },
      builder: (BuildContext context, ChangePasswordState state) {
        final bool isLoading = state is ChangePasswordLoading;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 22.h),
          decoration: BoxDecoration(
            color: AppColors.profileCardSurface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.profileDivider),
            boxShadow: const [
              BoxShadow(
                color: AppColors.authShadowSoft,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppText(
                ProfileStrings.currentPasswordLabel,
                style: font14w500.copyWith(color: AppColors.authLabel),
              ),
              verticalSpacing(8),
              ProfilePasswordField(
                controller: currentPasswordController,
                hintText: ProfileStrings.currentPasswordHint,
              ),
              verticalSpacing(12),
              AppText(
                ProfileStrings.newPasswordLabel,
                style: font14w500.copyWith(color: AppColors.authLabel),
              ),
              verticalSpacing(8),
              ProfilePasswordField(
                controller: newPasswordController,
                hintText: ProfileStrings.newPasswordHint,
              ),
              verticalSpacing(16),
              AppText(
                ProfileStrings.confirmPasswordLabel,
                style: font14w500.copyWith(color: AppColors.authLabel),
              ),
              verticalSpacing(8),
              ProfilePasswordField(
                controller: confirmPasswordController,
                hintText: ProfileStrings.confirmPasswordHint,
                textInputAction: TextInputAction.done,
              ),
              verticalSpacing(10),
              NewPasswordValidationSteps(controller: newPasswordController),
              verticalSpacing(18),
              Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  AppButton(
                    text: ProfileStrings.submitButton,
                    onPressed: isLoading
                        ? null
                        : () {
                            context.read<ChangePasswordCubit>().changePassword(
                              currentPassword: currentPasswordController.text
                                  .trim(),
                              newPassword: newPasswordController.text.trim(),
                              confirmNewPassword: confirmPasswordController.text
                                  .trim(),
                            );
                          },
                    color: AppColors.authPrimary,
                    textColor: Colors.white,
                    textSize: 16.sp,
                    textWeight: FontWeight.w600,
                    radius: 13.r,
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
          ),
        );
      },
    );
  }
}
