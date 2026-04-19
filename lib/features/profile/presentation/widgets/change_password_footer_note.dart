import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/profile/presentation/constants/profile_strings.dart';

class ChangePasswordFooterNote extends StatelessWidget {
  const ChangePasswordFooterNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.profileCardSurface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.profileDivider),
      ),
      child: AppText(
        ProfileStrings.footerNote,
        alignment: AlignmentDirectional.center,
        textAlign: TextAlign.center,
        style: font14w400.copyWith(color: AppColors.profileFooterText),
        maxLines: 3,
      ),
    );
  }
}
