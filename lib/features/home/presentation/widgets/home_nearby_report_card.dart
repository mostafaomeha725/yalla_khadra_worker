import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yallakhadra/core/routes/route_paths.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/app_image.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/home/domain/entities/home_nearby_report_entity.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_info_row.dart';

class HomeNearbyReportCard extends StatelessWidget {
  final HomeNearbyReportEntity report;

  const HomeNearbyReportCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return BounceIt(
      onPressed: () {
        context.push(Routes.homeReportDetailsScreen, extra: report);
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(26.r),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x140F172A),
              blurRadius: 14,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage(
              imageUrl: report.imageUrl,
              width: 94.w,
              height: 94.w,
              fit: BoxFit.cover,
              showprogressIndicator: false,
              borderRadius: BorderRadius.circular(22.r),
            ),
            horizontalSpacing(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    report.title,
                    maxLines: 2,
                    style: font16w700.copyWith(color: const Color(0xFF0F172A)),
                  ),
                  verticalSpacing(8),
                  HomeInfoRow(
                    icon: Icons.location_on_outlined,
                    value: report.distance,
                    iconColor: const Color(0xFF10B981),
                    textColor: const Color(0xFF475569),
                  ),
                  verticalSpacing(6),
                  HomeInfoRow(
                    icon: Icons.calendar_today_outlined,
                    value: report.timeAgo,
                    iconColor: const Color(0xFF94A3B8),
                    textColor: const Color(0xFF475569),
                  ),
                  verticalSpacing(6),
                  HomeInfoRow(
                    icon: Icons.inventory_2_outlined,
                    value: report.wasteType,
                    iconColor: const Color(0xFF94A3B8),
                    textColor: const Color(0xFF475569),
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
