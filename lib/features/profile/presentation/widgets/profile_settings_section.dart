import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/helpers/helpers.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/profile/presentation/constants/profile_strings.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/profile_setting_item.dart';

class ProfileSettingsSection extends StatelessWidget {
  const ProfileSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          ProfileStrings.accountSettingsTitle,
          style: font16w700.copyWith(color: AppColors.authHeading),
        ),
        verticalSpacing(12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.profileCardSurface,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: AppColors.profileDivider),
          ),
          child: Column(
            children: [
              ProfileSettingItem(
                title: ProfileStrings.settingUpdateProfile,
                icon: Icons.person_outline_rounded,
                onTap: () => Helpers.handleOpenUpdateProfile(context),
              ),
              ProfileSettingItem(
                title: ProfileStrings.settingChangePassword,
                icon: Icons.lock_outline_rounded,
                onTap: () => Helpers.handleOpenChangePassword(context),
              ),
              ProfileSettingItem(
                title: ProfileStrings.settingPrivacyTerms,
                icon: Icons.description_outlined,
                onTap: () => Helpers.handleOpenPrivacyTerms(context),
                showDivider: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
