import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class MyWorksHeaderSection extends StatelessWidget {
  const MyWorksHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'My Works',
          style: font32w700.copyWith(color: const Color(0xFF111827)),
        ),
        SizedBox(height: 2.h),
        AppText(
          'Your cleanup history',
          style: font14w400.copyWith(color: const Color(0xFF6B7280)),
        ),
      ],
    );
  }
}
