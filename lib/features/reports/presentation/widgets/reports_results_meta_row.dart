import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class ReportsResultsMetaRow extends StatelessWidget {
  final int totalCount;

  const ReportsResultsMetaRow({super.key, required this.totalCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h, bottom: 24.h),
      child: Row(
        children: [
          AppText(
            '$totalCount reports found',
            style: font12w500.copyWith(color: const Color(0xFF6B7280)),
          ),
          // const Spacer(),
          // BounceIt(
          //   onPressed: () {},
          //   child: Row(
          //     children: [
          //       Icon(
          //         Icons.swap_vert,
          //         size: 14.sp,
          //         color: const Color(0xFF10B981),
          //       ),
          //       horizontalSpacing(4),
          //       AppText(
          //         'Sort by Distance',
          //         style: font12w500.copyWith(color: const Color(0xFF10B981)),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
