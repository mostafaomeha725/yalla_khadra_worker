import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/auth/presentation/widgets/forget_password_form_section.dart';

class ForgetPasswordCard extends StatelessWidget {
  const ForgetPasswordCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 26.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.11),
            blurRadius: 20.r,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 76.w,
              height: 76.w,
              decoration: BoxDecoration(
                color: const Color(0xFFBFEFE2),
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.07),
                    blurRadius: 12.r,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.mail_outline_rounded,
                size: 42.sp,
                color: const Color(0xFF059669),
              ),
            ),
          ),
          verticalSpacing(18),
          AppText(
            'Forget Password?',
            alignment: AlignmentDirectional.center,
            style: font24w700.copyWith(color: const Color(0xFF111827)),
          ),
          verticalSpacing(10),
          AppText(
            "Enter your email address and we'll\nsend you a code to reset your\npassword",
            alignment: AlignmentDirectional.center,
            style: font16w400.copyWith(color: const Color(0xFF6B7280)),
            textAlign: TextAlign.center,
          ),
          verticalSpacing(20),
          const ForgetPasswordFormSection(),
        ],
      ),
    );
  }
}
