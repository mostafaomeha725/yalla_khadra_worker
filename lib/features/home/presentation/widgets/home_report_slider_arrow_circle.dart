import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeReportSliderArrowCircle extends StatelessWidget {
  final IconData icon;

  const HomeReportSliderArrowCircle({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26.w,
      height: 26.w,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(13.r),
      ),
      child: Icon(icon, size: 14.sp, color: const Color(0xFF64748B)),
    );
  }
}
