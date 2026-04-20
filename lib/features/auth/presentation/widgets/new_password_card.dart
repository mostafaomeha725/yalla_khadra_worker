import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/auth/presentation/constants/auth_strings.dart';
import 'package:yallakhadra/features/auth/presentation/widgets/new_password_form_section.dart';

class NewPasswordCard extends StatelessWidget {
  const NewPasswordCard({required this.email, required this.code, super.key});

  final String email;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 22.h),
      decoration: BoxDecoration(
        color: AppColors.authSurface,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.authShadowStrong,
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: AppColors.authSoftMint,
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.authShadowSoft,
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.lock_outline_rounded,
                size: 40.sp,
                color: AppColors.authAccent,
              ),
            ),
          ),
          verticalSpacing(18),
          AppText(
            AuthStrings.newPasswordHeading,
            alignment: AlignmentDirectional.center,
            style: font24w700.copyWith(color: AppColors.authHeading),
          ),
          verticalSpacing(8),
          AppText(
            AuthStrings.newPasswordSubTitle,
            alignment: AlignmentDirectional.center,
            style: font16w400.copyWith(color: AppColors.authSubText),
          ),
          verticalSpacing(4),
          AppText(
            email.isEmpty ? AuthStrings.newPasswordTargetEmail : email,
            alignment: AlignmentDirectional.center,
            style: font16w500.copyWith(color: AppColors.authHeading),
          ),
          verticalSpacing(18),
          NewPasswordFormSection(email: email, code: code),
        ],
      ),
    );
  }
}
