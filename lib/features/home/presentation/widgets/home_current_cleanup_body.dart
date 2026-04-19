import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/light_colors.dart';
import 'package:yallakhadra/core/widgets/app_brand_header.dart';
import 'package:yallakhadra/core/widgets/custom_button.dart';
import 'package:yallakhadra/features/home/domain/entities/home_cleanup_task_entity.dart';
import 'package:yallakhadra/features/home/domain/entities/home_nearby_report_entity.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_current_cleanup_location_details_card.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_current_cleanup_upload_proof_card.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_current_cleanup_waste_details_card.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_details_top_bar.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_image_slider_card.dart';

class HomeCurrentCleanupBody extends StatelessWidget {
  final HomeCleanupTaskEntity task;

  const HomeCurrentCleanupBody({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final HomeNearbyReportEntity report = HomeNearbyReportEntity(
      title: '${task.title} ${task.subTitle}',
      distance: task.distance.replaceAll(' away', ''),
      timeAgo: task.timeAgo.replaceFirst('Taken ', ''),
      wasteType: task.wasteType,
      imageUrl: task.imageUrl,
    );

    return Container(
      width: double.infinity,
      color: AppLightColors.defaultBackground,
      child: SafeArea(
        child: Column(
          children: [
            const AppBrandHeader(),
            const Divider(height: 1, color: Color(0xFFE2E8F0)),
            const HomeReportDetailsTopBar(title: 'Current Cleanup'),
            const Divider(height: 1, color: Color(0xFFE2E8F0)),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 130.h),
                child: Column(
                  children: [
                    HomeReportImageSliderCard(imageUrl: task.imageUrl),
                    SizedBox(height: 12.h),
                    HomeCurrentCleanupLocationDetailsCard(report: report),
                    SizedBox(height: 12.h),
                    const HomeCurrentCleanupUploadProofCard(),
                    SizedBox(height: 12.h),
                    const HomeCurrentCleanupWasteDetailsCard(),
                    SizedBox(height: 12.h),
                    AppButton(
                      text: 'Complete Cleanup',
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
