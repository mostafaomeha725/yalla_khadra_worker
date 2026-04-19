import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class HomeReportDetailsTopBar extends StatelessWidget {
  final String title;

  const HomeReportDetailsTopBar({super.key, this.title = 'Report Details'});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        children: [
          BounceIt(
            onPressed: context.pop,
            child: Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 14.sp,
                color: const Color(0xFF475569),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          AppText(
            title,
            style: font16w700.copyWith(color: const Color(0xFF1E293B)),
          ),
        ],
      ),
    );
  }
}
