import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/home/domain/entities/home_dashboard_entity.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_current_cleanup_section.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_nearby_reports_section.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_overview_section.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_welcome_banner.dart';

class HomeDashboardContent extends StatelessWidget {
  final HomeDashboardEntity? dashboard;
  final String? errorMessage;

  const HomeDashboardContent({super.key, required this.dashboard})
    : errorMessage = null;

  const HomeDashboardContent.error({super.key, required String message})
    : dashboard = null,
      errorMessage = message;

  @override
  Widget build(BuildContext context) {
    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: AppText(
            errorMessage!,
            textAlign: TextAlign.center,
            style: font16w500.copyWith(color: const Color(0xFF475569)),
          ),
        ),
      );
    }

    final HomeDashboardEntity data = dashboard!;
    final bool hasCurrentCleanup = data.currentCleanups.isNotEmpty;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeWelcomeBanner(),
          verticalSpacing(24),
          HomeOverviewSection(
            avgHours: data.avgHours,
            completedCount: data.completedCount,
          ),
          if (hasCurrentCleanup) ...[
            verticalSpacing(36),
            HomeCurrentCleanupSection(tasks: data.currentCleanups),
          ],
          verticalSpacing(36),
          const HomeNearbyReportsSection(),
          verticalSpacing(92),
        ],
      ),
    );
  }
}
