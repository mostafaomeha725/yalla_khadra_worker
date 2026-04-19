import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class ProfileSettingItem extends StatelessWidget {
  const ProfileSettingItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.showDivider = true,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BounceIt(
          onPressed: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
            child: Row(
              children: [
                Container(
                  width: 42.w,
                  height: 42.w,
                  decoration: BoxDecoration(
                    color: AppColors.profileSettingIconBackground,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(icon, size: 21.sp, color: AppColors.authLabel),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: AppText(
                    title,
                    style: font16w500.copyWith(color: AppColors.authHeading),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 26.sp,
                  color: AppColors.profileChevron,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Divider(height: 1, color: AppColors.profileDivider),
      ],
    );
  }
}
