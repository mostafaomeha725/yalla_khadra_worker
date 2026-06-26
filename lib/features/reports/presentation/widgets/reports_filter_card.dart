import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';

import 'package:yallakhadra/core/widgets/app_svg.dart';
import 'package:yallakhadra/core/widgets/custom_button.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class ReportsFilterCard extends StatelessWidget {
  final String? selectedRadius;
  final VoidCallback onApplyPressed;
  final ValueChanged<String?> onRadiusChanged;

  const ReportsFilterCard({
    super.key,
    required this.selectedRadius,
    required this.onApplyPressed,
    required this.onRadiusChanged,
  });

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
                'Radius is optional',
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
          DropdownButtonHideUnderline(
            child: InputDecorator(
              decoration: InputDecoration(
                hintText: 'Leave empty for no radius filter',
                hintStyle: font14w400.copyWith(color: const Color(0xFF6B7280)),
                filled: true,
                fillColor: const Color(0xFFF9FAFB),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 10.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: Color(0xFF10B981)),
                ),
              ),
              child: DropdownButton<String?>(
                value: selectedRadius,
                onChanged: onRadiusChanged,
                isDense: true,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF6B7280),
                ),
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                items: [
                  DropdownMenuItem<String?>(
                    value: null,
                    child: AppText(
                      'No Radius Filter',
                      style: font14w400.copyWith(
                        color: const Color(0xFF111827),
                      ),
                      alignment: AlignmentDirectional.centerStart,
                    ),
                  ),
                  ...List.generate(10, (index) {
                    final String value = ((index + 1) * 10).toString();
                    return DropdownMenuItem<String?>(
                      value: value,
                      child: AppText(
                        '$value km',
                        style: font14w400.copyWith(
                          color: const Color(0xFF111827),
                        ),
                        alignment: AlignmentDirectional.centerStart,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          verticalSpacing(12),
          AppButton(
            text: 'Apply Filter',
            onPressed: onApplyPressed,
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
