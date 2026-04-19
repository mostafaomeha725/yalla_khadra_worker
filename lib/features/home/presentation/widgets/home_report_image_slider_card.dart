import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/widgets/app_image.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_slider_arrow_circle.dart';

class HomeReportImageSliderCard extends StatelessWidget {
  final String imageUrl;

  const HomeReportImageSliderCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: AppImage(
              imageUrl: imageUrl,
              width: double.infinity,
              height: 210.h,
              fit: BoxFit.cover,
              showprogressIndicator: false,
            ),
          ),
          Positioned(
            left: 8.w,
            top: 0,
            bottom: 0,
            child: Center(
              child: BounceIt(
                onPressed: () {},
                child: HomeReportSliderArrowCircle(
                  icon: Icons.arrow_back_ios_new_rounded,
                ),
              ),
            ),
          ),
          Positioned(
            right: 8.w,
            top: 0,
            bottom: 0,
            child: Center(
              child: BounceIt(
                onPressed: () {},
                child: HomeReportSliderArrowCircle(
                  icon: Icons.arrow_forward_ios_rounded,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
