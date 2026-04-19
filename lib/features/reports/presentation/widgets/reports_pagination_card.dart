import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_button.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class ReportsPaginationCard extends StatelessWidget {
  const ReportsPaginationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: AppButton(
              text: 'Prev',
              onPressed: () {},
              height: 42.h,
              radius: 22.r,
              textSize: 12.sp,
              textWeight: FontWeight.w600,
              color: const Color(0xFF10B981),
            ),
          ),
          horizontalSpacing(8),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  'Page 2 of',
                  alignment: AlignmentDirectional.center,
                  style: font10w500.copyWith(color: const Color(0xFF6B7280)),
                ),
                AppText(
                  '3',
                  alignment: AlignmentDirectional.center,
                  style: font10w700.copyWith(color: const Color(0xFF111827)),
                ),
              ],
            ),
          ),
          horizontalSpacing(8),
          Expanded(
            flex: 2,
            child: AppButton(
              text: 'Next',
              onPressed: () {},
              height: 42.h,
              radius: 22.r,
              textSize: 12.sp,
              textWeight: FontWeight.w600,
              color: const Color(0xFF10B981),
            ),
          ),
        ],
      ),
    );
  }
}
