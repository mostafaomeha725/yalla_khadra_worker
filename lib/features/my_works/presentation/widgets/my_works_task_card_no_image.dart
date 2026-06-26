import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class MyWorksTaskCardNoImage extends StatelessWidget {
  const MyWorksTaskCardNoImage({
    super.key,
    required this.title,
    required this.time,
    required this.duration,
    this.onTap,
  });

  final String title;
  final String time;
  final String duration;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BounceIt(
      onPressed: onTap ?? () {},
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 16.w,
                  height: 16.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    size: 11.sp,
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
                horizontalSpacing(6),
                Expanded(
                  child: AppText(
                    title,
                    maxLines: 2,
                    style: font14w700.copyWith(color: const Color(0xFF111827)),
                  ),
                ),
              ],
            ),
            verticalSpacing(7),
            Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 13.sp,
                  color: const Color(0xFF10B981),
                ),
                horizontalSpacing(6),
                Expanded(
                  child: AppText(
                    time,
                    style: font12w400.copyWith(color: const Color(0xFF6B7280)),
                  ),
                ),
              ],
            ),
            verticalSpacing(2),
            AppText(
              'Duration: $duration',
              style: font12w400.copyWith(color: const Color(0xFF6B7280)),
            ),
          ],
        ),
      ),
    );
  }
}
