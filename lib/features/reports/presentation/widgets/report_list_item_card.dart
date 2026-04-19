import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/app_image.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_info_row.dart';

class ReportListItemCard extends StatelessWidget {
  const ReportListItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.distance,
    required this.timeAgo,
    required this.wasteType,
  });

  final String imageUrl;
  final String title;
  final String distance;
  final String timeAgo;
  final String wasteType;

  @override
  Widget build(BuildContext context) {
    return BounceIt(
      onPressed: () {},
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage(
              imageUrl: imageUrl,
              width: 66.w,
              height: 66.w,
              fit: BoxFit.cover,
              showprogressIndicator: false,
              borderRadius: BorderRadius.circular(12.r),
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
                  HomeInfoRow(
                    icon: Icons.location_on_outlined,
                    value: distance,
                    iconColor: const Color(0xFF10B981),
                    textColor: const Color(0xFF64748B),
                    iconSize: 14.sp,
                    textSize: 12.sp,
                    textWeight: FontWeight.w500,
                  ),
                  verticalSpacing(4),
                  HomeInfoRow(
                    icon: Icons.calendar_today_outlined,
                    value: timeAgo,
                    iconColor: const Color(0xFF9CA3AF),
                    textColor: const Color(0xFF64748B),
                    iconSize: 13.sp,
                    textSize: 11.sp,
                  ),
                  verticalSpacing(4),
                  HomeInfoRow(
                    icon: Icons.inventory_2_outlined,
                    value: wasteType,
                    iconColor: const Color(0xFF9CA3AF),
                    textColor: const Color(0xFF64748B),
                    iconSize: 13.sp,
                    textSize: 11.sp,
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
