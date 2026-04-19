import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class PasswordRuleStatusItem extends StatelessWidget {
  const PasswordRuleStatusItem({
    super.key,
    required this.label,
    required this.isValid,
  });

  final String label;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: isValid
                ? AppColors.profileRuleSuccessBackground
                : AppColors.profileRuleInactiveBackground,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            Icons.check_rounded,
            size: 14.sp,
            color: isValid
                ? AppColors.profileRuleSuccess
                : AppColors.profileRuleInactive,
          ),
        ),
        SizedBox(width: 8.w),
        AppText(
          label,
          style: font16w500.copyWith(
            color: isValid
                ? AppColors.profileRuleSuccess
                : AppColors.profileRuleInactive,
          ),
        ),
      ],
    );
  }
}
