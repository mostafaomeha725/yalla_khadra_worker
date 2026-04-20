import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/my_works/domain/entities/my_work_overview_entity.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_summary_stat_item.dart';

class MyWorksSummaryCard extends StatelessWidget {
  final MyWorkOverviewEntity overview;

  const MyWorksSummaryCard({super.key, required this.overview});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              AppText(
                'My Works',
                style: font14w700.copyWith(color: const Color(0xFFFFFFFF)),
              ),
              const Spacer(),
              Icon(
                Icons.check_circle_outline_rounded,
                size: 18.sp,
                color: const Color(0xFFD1FAE5),
              ),
            ],
          ),
          verticalSpacing(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyWorksSummaryStatItem(
                value: '${overview.completedCleanupsCount}',
                label: 'Completed',
              ),
              MyWorksSummaryStatItem(
                value: overview.totalHours % 1 == 0
                    ? overview.totalHours.toStringAsFixed(0)
                    : overview.totalHours.toStringAsFixed(1),
                label: 'Hours',
              ),
              MyWorksSummaryStatItem(
                value:
                    '${overview.totalWeightInKg % 1 == 0 ? overview.totalWeightInKg.toStringAsFixed(0) : overview.totalWeightInKg.toStringAsFixed(1)}kg',
                label: 'Waste',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
