import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class ReportsSectionHeader extends StatelessWidget {
  const ReportsSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        AppText(
          'Available Reports',
          style: font28w500.copyWith(
            color: const Color(0xFF111827),
            fontWeight: FontWeight.w700,
          ),
        ),
        AppText(
          'Choose a task to start cleaning',
          style: font12w500.copyWith(color: const Color(0xFF6B7280)),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
