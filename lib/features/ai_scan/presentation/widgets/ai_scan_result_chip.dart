import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class AiScanResultChip extends StatelessWidget {
  const AiScanResultChip({
    super.key,
    required this.text,
    required this.icon,
    required this.textColor,
    required this.backgroundColor,
  });

  final String text;
  final IconData icon;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.sp, color: textColor),
          SizedBox(width: 4.w),
          AppText(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
