import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class HomeCleanupMediaActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final VoidCallback onPressed;

  const HomeCleanupMediaActionButton({
    super.key,
    required this.text,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BounceIt(
        onPressed: onPressed,
        child: Container(
          height: 88.h,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: borderColor, width: 1.2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 25.sp, color: iconColor),
              SizedBox(height: 8.h),
              AppText(
                text,
                alignment: AlignmentDirectional.center,
                style: font16w500.copyWith(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
