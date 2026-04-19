import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/helpers/helpers.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_button.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/auth/presentation/constants/auth_strings.dart';
import 'package:yallakhadra/features/auth/presentation/widgets/new_password_input_field.dart';

class NewPasswordFormSection extends StatefulWidget {
  const NewPasswordFormSection({super.key});

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
              onPressed: () => Helpers.handleChangePassword(
                context: context,
                newPassword: newPasswordController.text.trim(),
                confirmPassword: confirmPasswordController.text.trim(),
              ),
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
  }
}
