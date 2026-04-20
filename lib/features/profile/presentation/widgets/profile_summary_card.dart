import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/cache/preferences_storage.dart';
import 'package:yallakhadra/core/di/services_locator.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/profile/presentation/constants/profile_strings.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final PreferencesStorage prefs = sl<PreferencesStorage>();
    final String firstName = prefs.getFirstName();
    final String lastName = prefs.getLastName();
    final String email = prefs.getEmail();
    final String fullName = ('$firstName $lastName').trim();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 22.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.profileSummaryGradientStart,
            AppColors.profileSummaryGradientEnd,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.authShadowSoft,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 88.w,
            height: 88.w,
            decoration: BoxDecoration(
              color: AppColors.authWhite,
              borderRadius: BorderRadius.circular(44.r),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.authShadowSoft,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              Icons.person_outline_rounded,
              size: 50.sp,
              color: AppColors.authPrimary,
            ),
          ),
          verticalSpacing(18),
          AppText(
            fullName.isEmpty ? ProfileStrings.profileName : fullName,
            alignment: AlignmentDirectional.center,
            style: font24w800.copyWith(color: AppColors.authWhite),
          ),
          verticalSpacing(6),
          AppText(
            email.isEmpty ? ProfileStrings.profileEmail : email,
            alignment: AlignmentDirectional.center,
            style: font16w500.copyWith(color: AppColors.profileSummaryEmail),
          ),
          verticalSpacing(16),
        ],
      ),
    );
  }
}
