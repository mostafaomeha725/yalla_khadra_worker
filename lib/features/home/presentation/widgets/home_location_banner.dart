import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/helpers/helpers.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/custom_button.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

enum HomeLocationBannerType { permissionDenied, deniedForever, serviceDisabled }

class HomeLocationBanner extends StatelessWidget {
  final HomeLocationBannerType type;
  final VoidCallback onDismiss;

  const HomeLocationBanner({
    super.key,
    required this.type,
    required this.onDismiss,
  });

  String get _title {
    switch (type) {
      case HomeLocationBannerType.permissionDenied:
        return 'Location Access Required';
      case HomeLocationBannerType.deniedForever:
        return 'Permission Permanently Denied';
      case HomeLocationBannerType.serviceDisabled:
        return 'GPS is Turned Off';
    }
  }

  String get _subtitle {
    switch (type) {
      case HomeLocationBannerType.permissionDenied:
        return 'Enable location to discover nearby waste reports.';
      case HomeLocationBannerType.deniedForever:
        return 'Open app settings to grant location permission.';
      case HomeLocationBannerType.serviceDisabled:
        return 'Turn on GPS to get accurate nearby reports.';
    }
  }

  String get _buttonLabel {
    switch (type) {
      case HomeLocationBannerType.permissionDenied:
        return 'Enable Location';
      case HomeLocationBannerType.deniedForever:
        return 'Open Settings';
      case HomeLocationBannerType.serviceDisabled:
        return 'Turn On GPS';
    }
  }

  Future<void> _onTap() async {
    switch (type) {
      case HomeLocationBannerType.permissionDenied:
      case HomeLocationBannerType.deniedForever:
        await Helpers.handleEnableLocation();
        break;
      case HomeLocationBannerType.serviceDisabled:
        await Helpers.handleOpenLocationSettings();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF1F1), Color(0xFFFFE4E4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFFFCDD2), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEF5350).withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(14.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: const Color(0xFFEF5350).withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.location_off_rounded,
                color: const Color(0xFFEF5350),
                size: 20.r,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    _title,
                    style: font14w700.copyWith(color: const Color(0xFFB71C1C)),
                  ),
                  SizedBox(height: 2.h),
                  AppText(
                    _subtitle,
                    style: font12w400.copyWith(
                      color: const Color(0xFFEF5350).withValues(alpha: 0.85),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Align(
                      alignment: Alignment.center,
                      child: AppButton(
                        text: _buttonLabel,
                        onPressed: _onTap,
                        color: const Color(0xFFEF5350),
                        textColor: Colors.white,
                        radius: 20.r,
                        height: 36.h,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                        textSize: 12,
                        textWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onDismiss,
              child: Icon(
                Icons.close_rounded,
                color: const Color(0xFFEF5350).withValues(alpha: 0.6),
                size: 18.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
