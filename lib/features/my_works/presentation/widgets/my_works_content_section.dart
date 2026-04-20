import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/my_works/domain/entities/my_work_overview_entity.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_header_section.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_meta_row.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_summary_card.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_tasks_list_section.dart';
import 'package:yallakhadra/features/reports/presentation/widgets/reports_pagination_card.dart';

class MyWorksContentSection extends StatelessWidget {
  final MyWorkOverviewEntity? overview;
  final String? errorMessage;

  const MyWorksContentSection({super.key, required this.overview})
    : errorMessage = null;

  const MyWorksContentSection.error({super.key, required String message})
    : overview = null,
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

    final MyWorkOverviewEntity data = overview!;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(22.w, 12.h, 22.w, 110.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MyWorksHeaderSection(),
          SizedBox(height: 10.h),
          MyWorksSummaryCard(overview: data),
          SizedBox(height: 12.h),
          MyWorksMetaRow(completedCount: data.completedCleanupsCount),
          SizedBox(height: 8.h),
          const MyWorksTasksListSection(),
          const ReportsPaginationCard(),
        ],
      ),
    );
  }
}
