import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/my_works/domain/entities/my_work_overview_entity.dart';
import 'package:yallakhadra/features/my_works/domain/entities/my_work_reports_page_entity.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_header_section.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_meta_row.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_summary_card.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_tasks_list_section.dart';
import 'package:yallakhadra/features/my_works/presentation/cubit/my_work_overview/my_work_overview_cubit.dart';
import 'package:yallakhadra/features/reports/presentation/widgets/reports_pagination_card.dart';

class MyWorksContentSection extends StatelessWidget {
  final MyWorkOverviewEntity? overview;
  final MyWorkReportsPageEntity? reportsPage;
  final String? errorMessage;

  const MyWorksContentSection({
    super.key,
    required this.overview,
    required this.reportsPage,
  }) : errorMessage = null;

  const MyWorksContentSection.error({super.key, required String message})
    : overview = null,
      reportsPage = null,
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
    final MyWorkReportsPageEntity pageData = reportsPage!;

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
          MyWorksTasksListSection(reports: pageData.reports),
          ReportsPaginationCard(
            currentPage: pageData.currentPage,
            totalPages: pageData.totalPages,
            hasPreviousPage: pageData.hasPreviousPage,
            hasNextPage: pageData.hasNextPage,
            onPreviousPressed: () {
              context.read<MyWorkOverviewCubit>().loadPreviousPage();
            },
            onNextPressed: () {
              context.read<MyWorkOverviewCubit>().loadNextPage();
            },
          ),
        ],
      ),
    );
  }
}
