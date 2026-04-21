import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/helpers/helpers.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/app_brand_header.dart';
import 'package:yallakhadra/features/profile/presentation/constants/profile_strings.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/change_password_title_bar.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/privacy_contact_card.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/privacy_intro_card.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/privacy_section_card.dart';

class PrivacyScreenBody extends StatelessWidget {
  const PrivacyScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.profileBackground,
      child: SafeArea(
        child: Column(
          children: [
            const AppBrandHeader(),
            const Divider(height: 1, color: AppColors.profileDivider),
            const ChangePasswordTitleBar(title: ProfileStrings.privacyTitle),
            const Divider(height: 1, color: AppColors.profileDivider),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                child: Column(
                  children: [
                    const PrivacyIntroCard(),
                    verticalSpacing(12),
                    const PrivacySectionCard(
                      title: ProfileStrings.privacyCollectionTitle,
                      icon: Icons.assignment_ind_outlined,
                      items: ProfileStrings.privacyCollectionItems,
                    ),
                    verticalSpacing(12),
                    const PrivacySectionCard(
                      title: ProfileStrings.privacyUsageTitle,
                      icon: Icons.rule_folder_outlined,
                      items: ProfileStrings.privacyUsageItems,
                    ),
                    verticalSpacing(12),
                    const PrivacySectionCard(
                      title: ProfileStrings.privacyProtectionTitle,
                      icon: Icons.verified_user_outlined,
                      items: ProfileStrings.privacyProtectionItems,
                    ),
                    verticalSpacing(12),
                    PrivacyContactCard(
                      onPressed: () => LauncherHelper.sendMail(
                        ProfileStrings.privacySupportEmail,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
