import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_summary_stat_item.dart';

class MyWorksSummaryCard extends StatelessWidget {
  const MyWorksSummaryCard({super.key});

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
            children: const [
              MyWorksSummaryStatItem(value: '12', label: 'Completed'),
              MyWorksSummaryStatItem(value: '8.5', label: 'Hours'),
              MyWorksSummaryStatItem(value: '45kg', label: 'Waste'),
            ],
          ),
        ],
      ),
    );
  }
}
