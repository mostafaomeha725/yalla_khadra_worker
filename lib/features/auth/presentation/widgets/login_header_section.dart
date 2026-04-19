import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class LoginHeaderSection extends StatelessWidget {
  const LoginHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 88.w,
          height: 88.w,
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: const Color(0xFF10B981),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: AppText(
                  'YK',
                  alignment: AlignmentDirectional.center,
                  style: font24w700.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        verticalSpacing(22),
        AppText(
          'Yalla Khadra',
          alignment: AlignmentDirectional.center,
          style: font24w700.copyWith(color: const Color(0xFF111827)),
        ),
        verticalSpacing(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              'Join the green movement',
              alignment: AlignmentDirectional.center,
              style: font16w400.copyWith(color: const Color(0xFF009966)),
            ),
            horizontalSpacing(6),
            Icon(
              Icons.eco_rounded,
              size: 18.sp,
              color: const Color(0xFF84CC16),
            ),
          ],
        ),
        verticalSpacing(34),
      ],
    );
  }
}
