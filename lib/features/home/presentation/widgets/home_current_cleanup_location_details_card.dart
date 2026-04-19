import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/home/domain/entities/home_nearby_report_entity.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_information_item.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_location_map_card.dart';

class HomeCurrentCleanupLocationDetailsCard extends StatelessWidget {
  final HomeNearbyReportEntity report;

  const HomeCurrentCleanupLocationDetailsCard({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'Location Details',
            style: font14w700.copyWith(color: const Color(0xFF0F172A)),
          ),
          SizedBox(height: 10.h),
          HomeReportInformationItem(
            icon: Icons.location_on_outlined,
            iconColor: const Color(0xFF10B981),
            label: 'Location',
            value: report.title,
          ),
          HomeReportInformationItem(
            icon: Icons.inventory_2_outlined,
            iconColor: const Color(0xFF64748B),
            label: 'Waste Type',
            value: report.wasteType,
          ),
          HomeReportLocationMapCard(
            locationQuery: report.title,
            title: '',
            showTitle: false,
            cardPadding: EdgeInsets.zero,
            mapHeight: 98.h,
            actionButtonColor: const Color(0xFF10B981),
            actionButtonBorderColor: const Color(0xFF10B981),
            actionTextColor: Colors.white,
            actionIconColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
