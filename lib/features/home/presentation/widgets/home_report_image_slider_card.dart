import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/widgets/app_image.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_slider_arrow_circle.dart';

class HomeReportImageSliderCard extends StatelessWidget {
  final List<String> imageUrls;

  const HomeReportImageSliderCard({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

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
            child: SizedBox(
              width: double.infinity,
              height: 210.h,
              child: PageView.builder(
                controller: pageController,
                itemCount: imageUrls.length,
                onPageChanged: (int index) {
                  currentIndex.value = index;
                },
                itemBuilder: (BuildContext context, int index) {
                  return AppImage(
                    imageUrl: imageUrls[index],
                    width: double.infinity,
                    height: 210.h,
                    fit: BoxFit.cover,
                    showprogressIndicator: false,
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 8.w,
            top: 0,
            bottom: 0,
            child: Center(
              child: BounceIt(
                onPressed: () {
                  final int previous = (currentIndex.value - 1).clamp(
                    0,
                    imageUrls.length - 1,
                  );
                  pageController.animateToPage(
                    previous,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                  );
                },
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
                onPressed: () {
                  final int next = (currentIndex.value + 1).clamp(
                    0,
                    imageUrls.length - 1,
                  );
                  pageController.animateToPage(
                    next,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                  );
                },
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
