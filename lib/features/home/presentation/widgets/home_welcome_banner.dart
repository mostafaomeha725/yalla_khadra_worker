import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/home/presentation/constants/home_strings.dart';

class HomeWelcomeBanner extends StatelessWidget {
  final String workerName;

  const HomeWelcomeBanner({super.key, required this.workerName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        gradient: const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF0EA5A3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A0F172A),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'Welcome back, $workerName',
            style: font22w500.copyWith(color: Colors.white),
            alignment: AlignmentDirectional.center,
          ),
          SizedBox(height: 8.h),
          AppText(
            HomeStrings.welcomeMessage,
            style: font14w400.copyWith(color: const Color(0xFFE2FBEF)),
            alignment: AlignmentDirectional.center,
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
