import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/home/domain/entities/home_nearby_report_entity.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_information_item.dart';

class HomeReportInformationCard extends StatelessWidget {
  final HomeNearbyReportEntity report;

  const HomeReportInformationCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'Report Information',
            style: font14w700.copyWith(color: const Color(0xFF0F172A)),
          ),
          SizedBox(height: 12.h),
          HomeReportInformationItem(
            icon: Icons.location_on_outlined,
            iconColor: const Color(0xFF64748B),
            label: 'Location',
            value: report.title,
            accentValue: '${report.distance} away',
          ),
          HomeReportInformationItem(
            icon: Icons.inventory_2_outlined,
            iconColor: const Color(0xFF64748B),
            label: 'Waste Type',
            value: report.wasteType,
          ),
          HomeReportInformationItem(
            icon: Icons.calendar_today_outlined,
            iconColor: const Color(0xFFA855F7),
            label: 'Reported',
            value: report.timeAgo,
          ),
        ],
      ),
    );
  }
}
