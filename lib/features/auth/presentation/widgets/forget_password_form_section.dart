import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yallakhadra/core/helpers/helpers.dart';
import 'package:yallakhadra/core/routes/route_paths.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/easy_loading.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/app_form_field.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_button.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:yallakhadra/features/auth/presentation/cubit/forgot_password/forgot_password_state.dart';

class ForgetPasswordFormSection extends StatefulWidget {
  const ForgetPasswordFormSection({super.key});

  @override
  State<ForgetPasswordFormSection> createState() =>
      ForgetPasswordFormSectionState();
}

class ForgetPasswordFormSectionState extends State<ForgetPasswordFormSection> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (BuildContext context, ForgotPasswordState state) {
        if (state is ForgotPasswordLoading) {
          showLoading(
            status: 'Sending reset email...',
            userInteractions: false,
          );
        } else if (state is ForgotPasswordError) {
          hideLoading();
          showError(state.message);
        } else if (state is ForgotPasswordSuccess) {
          hideLoading();
          showSuccess(state.message);
          context.push(Routes.otpScreen, extra: emailController.text.trim());
        }
      },
      builder: (BuildContext context, ForgotPasswordState state) {
        final bool isLoading = state is ForgotPasswordLoading;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppText(
              'Email Address',
              style: font16w500.copyWith(color: const Color(0xFF374151)),
            ),
            verticalSpacing(8),
            AppFormField(
              controller: emailController,
              hintText: 'your@email.com',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              fillColor: const Color(0xFFF3F4F6),
              borderColor: const Color(0xFFE5E7EB),
              radius: 14.r,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 14.h,
              ),
              prefixIcon: Icon(
                Icons.mail_outline_rounded,
                size: 20.sp,
                color: const Color(0xFF98A2B3),
              ),
            ),
            verticalSpacing(18),
            Stack(
              alignment: AlignmentDirectional.centerStart,
              children: [
                AppButton(
                  text: 'Reset Password',
                  onPressed: isLoading
                      ? null
                      : () {
                          context
                              .read<ForgotPasswordCubit>()
                              .requestPasswordReset(
                                email: emailController.text.trim(),
                              );
                        },
                  color: const Color(0xFF10B981),
                  textColor: Colors.white,
                  textSize: 16.sp,
                  textWeight: FontWeight.w600,
                  radius: 14.r,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 16.w),
                  child: IgnorePointer(
                    child: Icon(
                      Icons.near_me_outlined,
                      size: 19.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            verticalSpacing(32),
            Center(
              child: BounceIt(
                onPressed: () => Helpers.handleBackToLogin(context),
                child: AppText(
                  'Back to Login',
                  alignment: AlignmentDirectional.center,
                  style: font16w500.copyWith(color: const Color(0xFF059669)),
                ),
              ),
            ),
            verticalSpacing(16),
          ],
        );
      },
    );
  }
}
