import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class PrivacySectionCard extends StatelessWidget {
  const PrivacySectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
  });

  final String title;
  final IconData icon;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.profileCardSurface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.profileDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: AppColors.profileSettingIconBackground,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, size: 20.sp, color: AppColors.authLabel),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: AppText(
                  title,
                  overflow: TextOverflow.visible,
                  style: font16w700.copyWith(color: AppColors.authHeading),
                ),
              ),
            ],
          ),
          verticalSpacing(14),
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 3.h),
                    child: Icon(
                      Icons.check_circle_rounded,
                      size: 18.sp,
                      color: AppColors.authPrimary,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: AppText(
                      item,
                      maxLines: 6,
                      overflow: TextOverflow.visible,
                      style: font14w400.copyWith(color: AppColors.authSubText),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
