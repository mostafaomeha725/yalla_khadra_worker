import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yallakhadra/core/helpers/helpers.dart';
import 'package:yallakhadra/core/routes/route_paths.dart';
import 'package:yallakhadra/features/my_works/domain/entities/my_work_report_entity.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_task_card.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_task_card_no_image.dart';

class MyWorksTasksListSection extends StatelessWidget {
  final List<MyWorkReportEntity> reports;

  const MyWorksTasksListSection({super.key, required this.reports});

  @override
  Widget build(BuildContext context) {
    if (reports.isEmpty) {
      return const SizedBox();
    }

    return Column(
      children: List.generate(reports.length, (index) {
        final report = reports[index];
        void onTap() {
          context.push(Routes.myWorkCompletedDetails, extra: report.reportId);
        }

        final card = report.firstImageUrl.trim().isEmpty
            ? MyWorksTaskCardNoImage(
                title: report.address,
                time: Helpers.formatMyWorkCompletedAt(report.completedAt),
                duration: Helpers.formatMyWorkDuration(report.duration),
                onTap: onTap,
              )
            : MyWorksTaskCard(
                imageUrl: report.firstImageUrl,
                title: report.address,
                time: Helpers.formatMyWorkCompletedAt(report.completedAt),
                duration: Helpers.formatMyWorkDuration(report.duration),
                onTap: onTap,
              );

        if (index == reports.length - 1) {
          return card;
        }

        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: card,
        );
      }),
    );
  }
}
