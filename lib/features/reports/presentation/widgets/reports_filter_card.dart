import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/app_form_field.dart';
import 'package:yallakhadra/core/widgets/app_svg.dart';
import 'package:yallakhadra/core/widgets/custom_button.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class ReportsFilterCard extends StatelessWidget {
  const ReportsFilterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 14.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppSVG(
                assetName: 'assets/svg/filter_badge.svg',
                width: 18.w,
                height: 18.w,
              ),
              horizontalSpacing(8),
              Expanded(
                child: AppText(
                  'Filter Nearby Reports',
                  style: font12w700.copyWith(color: const Color(0xFF111827)),
                ),
              ),
              AppText(
                'Within 5 km',
                style: font10w500.copyWith(color: const Color(0xFF6B7280)),
              ),
            ],
          ),
          verticalSpacing(14),
          AppText(
            'Search Radius (km)',
            style: font12w500.copyWith(color: const Color(0xFF374151)),
          ),
          verticalSpacing(8),
          AppFormField(
            controller: TextEditingController(text: '5'),
            hintText: '5',
            readOnly: true,
            fillColor: const Color(0xFFF9FAFB),
            borderColor: const Color(0xFFE5E7EB),
            radius: 10.r,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 10.h,
            ),
            hintColor: const Color(0xFF111827),
          ),
          verticalSpacing(12),
          AppButton(
            text: 'Apply Filter',
            onPressed: () {},
            height: 42.h,
            radius: 10.r,
            color: const Color(0xFF10B981),
            textSize: 14.sp,
            textWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
