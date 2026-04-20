import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/di/services_locator.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/app_brand_header.dart';
import 'package:yallakhadra/features/profile/presentation/cubit/profile_logout_cubit.dart';
import 'package:yallakhadra/features/profile/presentation/constants/profile_strings.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/change_password_title_bar.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/profile_logout_section.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/profile_settings_section.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/profile_summary_card.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

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
            const ChangePasswordTitleBar(
              title: ProfileStrings.profilePageTitle,
            ),
            const Divider(height: 1, color: AppColors.profileDivider),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                child: Column(
                  children: [
                    const ProfileSummaryCard(),
                    verticalSpacing(16),
                    const ProfileSettingsSection(),
                    verticalSpacing(16),
                    BlocProvider<ProfileLogoutCubit>(
                      create: (_) => sl<ProfileLogoutCubit>(),
                      child: const ProfileLogoutSection(),
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
