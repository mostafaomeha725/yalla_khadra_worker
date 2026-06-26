import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:yallakhadra/core/helpers/helpers.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_location_map_view.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_location_open_button.dart';

class HomeReportLocationMapCard extends StatelessWidget {
  final String locationQuery;
  final String title;
  final bool showTitle;
  final EdgeInsetsGeometry? cardPadding;
  final double? mapHeight;
  final Color? actionButtonColor;
  final Color? actionButtonBorderColor;
  final Color? actionTextColor;
  final Color? actionIconColor;

  /// Optional: pass real coordinates for the map marker.
  /// Falls back to Cairo when null.
  final double? latitude;
  final double? longitude;

  const HomeReportLocationMapCard({
    super.key,
    required this.locationQuery,
    this.title = 'Location Map',
    this.showTitle = true,
    this.cardPadding,
    this.mapHeight,
    this.actionButtonColor,
    this.actionButtonBorderColor,
    this.actionTextColor,
    this.actionIconColor,
    this.latitude,
    this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    final (double lat, double lng) = Helpers.resolveMapCenter(
      latitude: latitude,
      longitude: longitude,
    );
    final LatLng center = LatLng(lat, lng);

    return Container(
      width: double.infinity,
      padding:
          cardPadding ?? EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showTitle)
            AppText(
              title,
              style: font14w700.copyWith(color: const Color(0xFF0F172A)),
            ),
          if (showTitle) SizedBox(height: 10.h),
          HomeReportLocationMapView(
            center: center,
            height: mapHeight ?? 200.h,
            onTap: () => Helpers.openReportInGoogleMaps(
              locationQuery: locationQuery,
              latitude: latitude,
              longitude: longitude,
            ),
          ),
          SizedBox(height: 10.h),
          HomeReportLocationOpenButton(
            onPressed: () => Helpers.openReportInGoogleMaps(
              locationQuery: locationQuery,
              latitude: latitude,
              longitude: longitude,
            ),
            buttonColor: actionButtonColor,
            borderColor: actionButtonBorderColor,
            textColor: actionTextColor,
            iconColor: actionIconColor,
          ),
        ],
      ),
    );
  }
}
