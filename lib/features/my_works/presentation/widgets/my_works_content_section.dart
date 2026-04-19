import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_header_section.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_meta_row.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_summary_card.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_tasks_list_section.dart';
import 'package:yallakhadra/features/reports/presentation/widgets/reports_pagination_card.dart';

class MyWorksContentSection extends StatelessWidget {
  const MyWorksContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(22.w, 12.h, 22.w, 110.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MyWorksHeaderSection(),
          SizedBox(height: 10.h),
          const MyWorksSummaryCard(),
          SizedBox(height: 12.h),
          const MyWorksMetaRow(),
          SizedBox(height: 8.h),
          const MyWorksTasksListSection(),
          const ReportsPaginationCard(),
        ],
      ),
    );
  }
}
