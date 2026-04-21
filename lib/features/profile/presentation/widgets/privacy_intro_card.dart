import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/profile/presentation/constants/profile_strings.dart';

class PrivacyIntroCard extends StatelessWidget {
  const PrivacyIntroCard({super.key});

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
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: AppColors.profileRuleSuccessBackground,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              Icons.shield_outlined,
              size: 24.sp,
              color: AppColors.authPrimary,
            ),
          ),
          verticalSpacing(14),
          AppText(
            ProfileStrings.privacyIntroTitle,
            style: font18w700.copyWith(color: AppColors.authHeading),
          ),
          verticalSpacing(8),
          AppText(
            ProfileStrings.privacyIntroDescription,
            maxLines: 6,
            overflow: TextOverflow.visible,
            style: font14w400.copyWith(color: AppColors.authSubText),
          ),
          verticalSpacing(12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.profileTipsBackground,
              borderRadius: BorderRadius.circular(999.r),
            ),
            child: AppText(
              ProfileStrings.privacyLastUpdated,
              overflow: TextOverflow.visible,
              style: font12w700.copyWith(color: AppColors.profileTipsTitle),
            ),
          ),
        ],
      ),
    );
  }
}
