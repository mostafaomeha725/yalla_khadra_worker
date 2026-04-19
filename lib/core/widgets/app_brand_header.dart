import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yallakhadra/core/constants/strings.dart';
import 'package:yallakhadra/core/routes/route_paths.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class AppBrandHeader extends StatelessWidget {
  const AppBrandHeader({
    super.key,
    this.title = AppStrings.appName,
    this.subTitle = AppStrings.appRole,
    this.badgeText = 'YK',
    this.actionIcon = Icons.person_outline_rounded,
  });

  final String title;
  final String subTitle;
  final String badgeText;
  final IconData actionIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.authWhite,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: AppColors.authPrimary,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.authShadowSoft,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: AppText(
                badgeText,
                alignment: AlignmentDirectional.center,
                style: font12w700.copyWith(color: AppColors.authWhite),
              ),
            ),
          ),
          SizedBox(width: 9.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  title,
                  style: font14w700.copyWith(color: AppColors.authHeading),
                ),
                AppText(
                  subTitle,
                  style: font10w400.copyWith(color: AppColors.authSubText),
                ),
              ],
            ),
          ),
          BounceIt(
            onPressed: () {
              GoRouter.of(context).push(Routes.profileScreen);
            },
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: AppColors.authPrimary,
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.authShadowSoft,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(actionIcon, size: 21.sp, color: AppColors.authWhite),
            ),
          ),
        ],
      ),
    );
  }
}
