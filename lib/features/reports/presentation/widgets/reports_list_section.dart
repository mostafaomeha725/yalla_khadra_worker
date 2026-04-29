import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yallakhadra/core/routes/route_paths.dart';
import 'package:yallakhadra/core/enums/waste_type.dart';
import 'package:yallakhadra/core/helpers/helpers.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/home/domain/entities/home_nearby_report_entity.dart';
import 'package:yallakhadra/features/reports/domain/entities/nearby_report_entity.dart';
import 'package:yallakhadra/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:yallakhadra/features/reports/presentation/widgets/report_list_item_card.dart';

class ReportsListSection extends StatelessWidget {
  final List<NearbyReportEntity> reports;

  const ReportsListSection({super.key, required this.reports});

  @override
  Widget build(BuildContext context) {
    if (reports.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: AppText(
            'No reports found in your area.',
            style: font16w500.copyWith(color: const Color(0xFF6B7280)),
            textAlign: TextAlign.center,
            alignment: AlignmentDirectional.center,
          ),
        ),
      );
    }

    final double? userLat = context.read<ReportsCubit>().latitude;
    final double? userLng = context.read<ReportsCubit>().longitude;

    return Column(
      children: List.generate(reports.length, (index) {
        final NearbyReportEntity report = reports[index];
        final WasteType wasteType = WasteType.values.firstWhere(
          (WasteType item) => item.value == report.wasteType,
          orElse: () => WasteType.unknown,
        );

        final String distanceText = (userLat != null && userLng != null)
            ? Helpers.formatDistanceFromLatLng(
                startLatitude: userLat,
                startLongitude: userLng,
                targetLatitude: report.latitude,
                targetLongitude: report.longitude,
              )
            : '';

        final Widget distanceAwareCard = ReportListItemCard(
          imageUrl: report.imageUrl,
          title: report.address,
          distance: distanceText,
          timeAgo: Helpers.formatReportDate(report.createdAt),
          wasteType: wasteType.label,
          onPressed: () {
            context.push(
              Routes.homeReportDetailsScreen,
              extra: HomeNearbyReportEntity(
                title: report.address,
                distance: distanceText,
                timeAgo: Helpers.formatReportDate(report.createdAt),
                wasteType: wasteType.label,
                imageUrl: report.imageUrl,
                imageUrls: report.imageUrls,
              ),
            );
          },
        );

        if (index == reports.length - 1) {
          return distanceAwareCard;
        }

        return Column(children: [distanceAwareCard, verticalSpacing(10)]);
      }),
    );
  }
}
