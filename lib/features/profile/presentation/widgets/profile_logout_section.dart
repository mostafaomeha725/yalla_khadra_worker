import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/helpers/helpers.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/bouncing_social_button.dart';
import 'package:yallakhadra/core/widgets/custom_button.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/profile/presentation/constants/profile_strings.dart';

class ProfileLogoutSection extends StatelessWidget {
  const ProfileLogoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 8.h),
        BouncingSocialButton(
          text: 'Logout',
          onTap: () {},
          textColor: const Color(0xFFE53E3E),
          color: Color(0xfffff0f0),
          radius: 20.r,
          height: 52.h,
          textSize: 16.sp,
          borderColor: const Color(0x66E53E3E),
          leading: Icon(
            Icons.logout,
            size: 18.sp,
            color: const Color(0xFFE53E3E),
          ),
        ),
        verticalSpacing(12),
        AppText(
          ProfileStrings.appVersionLabel,
          alignment: AlignmentDirectional.center,
          style: font14w400.copyWith(color: AppColors.profileVersionText),
        ),
      ],
    );
  }
}
