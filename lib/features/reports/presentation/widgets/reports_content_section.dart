import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/features/reports/presentation/widgets/reports_filter_card.dart';
import 'package:yallakhadra/features/reports/presentation/widgets/reports_list_section.dart';
import 'package:yallakhadra/features/reports/presentation/widgets/reports_pagination_card.dart';
import 'package:yallakhadra/features/reports/presentation/widgets/reports_results_meta_row.dart';
import 'package:yallakhadra/features/reports/presentation/widgets/reports_section_header.dart';

class ReportsContentSection extends StatelessWidget {
  const ReportsContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF3F4F6),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 120.h),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReportsSectionHeader(),
                  ReportsFilterCard(),
                  ReportsResultsMetaRow(),
                  ReportsListSection(),
                  ReportsPaginationCard(),
                ],
              ),
            ),
          ),
          verticalSpacing(6),
        ],
      ),
    );
  }
}
