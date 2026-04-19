import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_button.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class MyWorksPaginationCard extends StatelessWidget {
  const MyWorksPaginationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
              text: '<  Prev',
              onPressed: () {},
              height: 40.h,
              radius: 20.r,
              color: const Color(0xFFF3F4F6),
              borderColor: const Color(0xFFE5E7EB),
              textColor: const Color(0xFF9CA3AF),
              textSize: 12.sp,
              textWeight: FontWeight.w500,
            ),
          ),
          horizontalSpacing(8),
          Expanded(
            child: Column(
              children: [
                AppText(
                  'Page 1 of',
                  alignment: AlignmentDirectional.center,
                  style: font10w500.copyWith(color: const Color(0xFF111827)),
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
              text: 'Next  >',
              onPressed: () {},
              height: 40.h,
              radius: 20.r,
              color: const Color(0xFF10B981),
              textColor: const Color(0xFFFFFFFF),
              textSize: 12.sp,
              textWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
