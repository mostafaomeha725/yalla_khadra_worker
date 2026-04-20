import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yallakhadra/core/helpers/helpers.dart';
import 'package:yallakhadra/core/routes/route_paths.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/easy_loading.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_button.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/auth/presentation/constants/auth_strings.dart';
import 'package:yallakhadra/features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:yallakhadra/features/auth/presentation/cubit/forgot_password/forgot_password_state.dart';
import 'package:yallakhadra/features/auth/presentation/widgets/otp_code_fields_row.dart';

class OtpFormSection extends StatefulWidget {
  const OtpFormSection({required this.email, super.key});

  final String email;

  @override
  State<OtpFormSection> createState() => OtpFormSectionState();
}

class OtpFormSectionState extends State<OtpFormSection> {
  final List<TextEditingController> codeControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> codeFocusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final controller in codeControllers) {
      controller.dispose();
    }
    for (final focusNode in codeFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (BuildContext context, ForgotPasswordState state) {
        if (state is ForgotPasswordLoading) {
          showLoading(status: 'Verifying code...', userInteractions: false);
        } else if (state is ForgotPasswordError) {
          hideLoading();
          showError(state.message);
        } else if (state is ForgotPasswordCodeVerified) {
          hideLoading();
          showSuccess(state.message);
          context.push(
            Routes.newPasswordScreen,
            extra: <String, dynamic>{'email': state.email, 'code': state.code},
          );
        }
      },
      builder: (BuildContext context, ForgotPasswordState state) {
        final bool isLoading = state is ForgotPasswordLoading;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OtpCodeFieldsRow(
              controllers: codeControllers,
              focusNodes: codeFocusNodes,
            ),
            verticalSpacing(26),
            AppButton(
              text: AuthStrings.otpVerifyButton,
              onPressed: isLoading
                  ? null
                  : () {
                      context.read<ForgotPasswordCubit>().verifyCode(
                        email: widget.email,
                        code: codeControllers.map((e) => e.text.trim()).join(),
                      );
                    },
              color: AppColors.authPrimary,
              textColor: Colors.white,
              textSize: 16.sp,
              textWeight: FontWeight.w600,
              radius: 14.r,
            ),
            verticalSpacing(24),
            AppText(
              AuthStrings.otpDidNotReceive,
              alignment: AlignmentDirectional.center,
              style: font16w400.copyWith(color: AppColors.authSubText),
            ),
            verticalSpacing(10),
            Center(
              child: BounceIt(
                onPressed: () => Helpers.handleResendOtp(context),
                child: AppText(
                  AuthStrings.otpResendCode,
                  alignment: AlignmentDirectional.center,
                  style: font18w500.copyWith(color: AppColors.authAccent),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
