import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_button.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/profile/presentation/constants/profile_strings.dart';

class PrivacyContactCard extends StatelessWidget {
  const PrivacyContactCard({super.key, required this.onPressed});

  final VoidCallback onPressed;

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
          AppText(
            ProfileStrings.privacyContactTitle,
            overflow: TextOverflow.visible,
            style: font16w700.copyWith(color: AppColors.authHeading),
          ),
          verticalSpacing(8),
          AppText(
            ProfileStrings.privacyContactDescription,
            maxLines: 5,
            overflow: TextOverflow.visible,
            style: font14w400.copyWith(color: AppColors.authSubText),
          ),
          verticalSpacing(12),
          AppText(
            ProfileStrings.privacySupportEmail,
            overflow: TextOverflow.visible,
            style: font14w700.copyWith(color: AppColors.authAccent),
          ),
          verticalSpacing(14),
          AppButton(
            text: ProfileStrings.privacyContactButton,
            onPressed: onPressed,
            color: AppColors.authPrimary,
            textColor: AppColors.authWhite,
            textSize: 16.sp,
            textWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
