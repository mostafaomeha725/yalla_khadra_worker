import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/profile/presentation/constants/profile_strings.dart';

class ChangePasswordTitleBar extends StatelessWidget {
  const ChangePasswordTitleBar({
    super.key,
    this.title = ProfileStrings.screenTitle,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.authWhite,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          BounceIt(
            onPressed: context.pop,
            child: Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: AppColors.authWhite,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.authShadowSoft,
                    blurRadius: 10.r,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18.sp,
                color: AppColors.authLabel,
              ),
            ),
          ),
          Expanded(
            child: AppText(
              title,
              alignment: AlignmentDirectional.center,
              style: font18w700.copyWith(color: AppColors.authHeading),
            ),
          ),
          SizedBox(width: 38.w, height: 38.w),
        ],
      ),
    );
  }
}
