import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/light_colors.dart';
import 'package:yallakhadra/core/widgets/app_brand_header.dart';
import 'package:yallakhadra/core/widgets/custom_button.dart';
import 'package:yallakhadra/features/home/domain/entities/home_nearby_report_entity.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_details_top_bar.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_image_slider_card.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_information_card.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_location_map_card.dart';

class HomeReportDetailsBody extends StatelessWidget {
  final HomeNearbyReportEntity report;

  const HomeReportDetailsBody({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final List<String> sliderImages = report.imageUrls.isNotEmpty
        ? report.imageUrls
        : <String>[report.imageUrl];

    return Container(
      width: double.infinity,
      color: AppLightColors.defaultBackground,
      child: SafeArea(
        child: Column(
          children: [
            const AppBrandHeader(),
            const Divider(height: 1, color: Color(0xFFE2E8F0)),
            const HomeReportDetailsTopBar(),
            const Divider(height: 1, color: Color(0xFFE2E8F0)),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(22.w, 12.h, 22.w, 130.h),
                child: Column(
                  children: [
                    HomeReportImageSliderCard(imageUrls: sliderImages),
                    SizedBox(height: 12.h),
                    HomeReportInformationCard(report: report),
                    SizedBox(height: 12.h),
                    HomeReportLocationMapCard(locationQuery: report.title),
                    SizedBox(height: 12.h),
                    AppButton(
                      text: 'Take This Report',
                      onPressed: () {},
                      color: const Color(0xFF10B981),
                      textColor: Colors.white,
                      textSize: 14.sp,
                      textWeight: FontWeight.w700,
                      radius: 10.r,
                      height: 52.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
