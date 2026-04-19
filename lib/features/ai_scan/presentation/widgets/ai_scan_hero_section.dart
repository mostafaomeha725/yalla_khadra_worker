import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class AiScanHeroSection extends StatelessWidget {
  const AiScanHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        children: [
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: const Color(0xFF10B981),
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x2410B981),
                  blurRadius: 12,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              Icons.autorenew_rounded,
              size: 24.sp,
              color: const Color(0xFFFFFFFF),
            ),
          ),
          SizedBox(height: 12.h),
          AppText(
            'AI Waste Scanner',
            alignment: AlignmentDirectional.center,
            style: font24w700.copyWith(color: const Color(0xFF111827)),
          ),
          SizedBox(height: 4.h),
          AppText(
            'Scan any item to check if it\'s recyclable',
            alignment: AlignmentDirectional.center,
            textAlign: TextAlign.center,
            style: font12w400.copyWith(color: const Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }
}
