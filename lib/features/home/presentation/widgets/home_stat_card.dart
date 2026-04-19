import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class HomeStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color iconBackground;

  const HomeStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.iconBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Container(
              width: 42.w,
              height: 46.h,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: Colors.white, size: 22.sp),
            ),
            horizontalSpacing(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  value,
                  style: font20w700.copyWith(color: const Color(0xFF0F172A)),
                ),
                AppText(
                  label,
                  style: font12w400.copyWith(color: const Color(0xFF64748B)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
