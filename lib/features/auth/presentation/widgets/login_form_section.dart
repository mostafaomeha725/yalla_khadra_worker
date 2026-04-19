import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yallakhadra/core/routes/route_paths.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/utils/validators.dart';
import 'package:yallakhadra/core/widgets/app_form_field.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_button.dart';
import 'package:yallakhadra/core/widgets/custom_snack_bar.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/auth/presentation/widgets/login_password_field.dart';

class LoginFormSection extends StatefulWidget {
  const LoginFormSection({super.key});

  @override
  State<LoginFormSection> createState() => LoginFormSectionState();
}

class LoginFormSectionState extends State<LoginFormSection> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleLogin() {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String? validationError = Validators.validateLoginCredentials(
      email: email,
      password: password,
    );

    if (validationError != null) {
      CustomSnackBar.showError(context, message: validationError);
      return;
    }
    context.go(Routes.mainNavigationScreen);

    CustomSnackBar.showSuccess(context, message: 'Login request sent.');
  }

  void handleForgotPassword() {
    context.push(Routes.forgetPasswordScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          'Worker Login',
          style: font20w700.copyWith(color: const Color(0xFF1F2937)),
        ),
        verticalSpacing(24),
        AppText(
          'Email',
          style: font16w500.copyWith(color: const Color(0xFF374151)),
        ),
        verticalSpacing(10),
        AppFormField(
          controller: emailController,
          hintText: 'your@email.com',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
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
        AppText(
          'Password',
          style: font16w500.copyWith(color: const Color(0xFF374151)),
        ),
        verticalSpacing(10),
        LoginPasswordField(controller: passwordController),
        verticalSpacing(12),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: BounceIt(
            onPressed: handleForgotPassword,
            child: AppText(
              'Forgot password?',
              style: font14w500.copyWith(color: const Color(0xFF10B981)),
              alignment: AlignmentDirectional.center,
            ),
          ),
        ),
        verticalSpacing(22),
        AppButton(
          text: 'Login',
          onPressed: handleLogin,
          color: const Color(0xFF10B981),
          textColor: Colors.white,
          textSize: 16.sp,
          textWeight: FontWeight.w600,
          radius: 14.r,
        ),
        verticalSpacing(20),
      ],
    );
  }
}
