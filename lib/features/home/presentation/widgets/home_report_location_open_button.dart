import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class HomeReportLocationOpenButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? iconColor;

  const HomeReportLocationOpenButton({
    super.key,
    required this.onPressed,
    this.buttonColor,
    this.borderColor,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return BounceIt(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 11.h),
        decoration: BoxDecoration(
          color: buttonColor ?? const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: borderColor ?? const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 16.sp,
              color: iconColor ?? const Color(0xFF475569),
            ),
            SizedBox(width: 6.w),
            AppText(
              'Open in Google Maps',
              style: font12w500.copyWith(
                color: textColor ?? const Color(0xFF334155),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
