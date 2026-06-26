import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class HomeReportLocationMapBadge extends StatelessWidget {
  const HomeReportLocationMapBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.open_in_new_rounded,
            size: 11.sp,
            color: const Color(0xFF4285F4),
          ),
          SizedBox(width: 3.w),
          AppText(
            'Google Maps',
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF4285F4),
            ),
          ),
        ],
      ),
    );
  }
}
