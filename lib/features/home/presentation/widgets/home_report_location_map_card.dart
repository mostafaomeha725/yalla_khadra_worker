import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/helpers/helpers.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

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
  });

  @override
  Widget build(BuildContext context) {
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
          Container(
            width: double.infinity,
            height: mapHeight ?? 126.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.map_outlined,
              size: 34.sp,
              color: const Color(0xFF94A3B8),
            ),
          ),
          SizedBox(height: 10.h),
          BounceIt(
            onPressed: () {
              Helpers.handleOpenGoogleMapsSearch(locationQuery);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 11.h),
              decoration: BoxDecoration(
                color: actionButtonColor ?? const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: actionButtonBorderColor ?? const Color(0xFFE2E8F0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16.sp,
                    color: actionIconColor ?? const Color(0xFF475569),
                  ),
                  SizedBox(width: 6.w),
                  AppText(
                    'Open in Google Maps',
                    style: font12w500.copyWith(
                      color: actionTextColor ?? const Color(0xFF334155),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
