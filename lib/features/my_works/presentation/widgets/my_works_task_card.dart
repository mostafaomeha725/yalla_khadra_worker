import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/app_image.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class MyWorksTaskCard extends StatelessWidget {
  const MyWorksTaskCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.time,
    required this.duration,
  });

  final String imageUrl;
  final String title;
  final String time;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return BounceIt(
      onPressed: () {},
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AppImage(
                  imageUrl: imageUrl,
                  width: 58.w,
                  height: 58.w,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(10.r),
                  showprogressIndicator: false,
                ),
                Positioned(
                  top: -6.h,
                  right: -6.w,
                  child: Container(
                    width: 22.w,
                    height: 22.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      size: 15.sp,
                      color: const Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
            horizontalSpacing(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title,
                    maxLines: 2,
                    style: font14w700.copyWith(color: const Color(0xFF111827)),
                  ),
                  verticalSpacing(6),
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
                          style: font12w400.copyWith(
                            color: const Color(0xFF6B7280),
                          ),
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
          ],
        ),
      ),
    );
  }
}
