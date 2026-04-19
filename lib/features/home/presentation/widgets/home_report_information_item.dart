import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class HomeReportInformationItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final String? accentValue;
  final Color? accentValueColor;

  const HomeReportInformationItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.accentValue,
    this.accentValueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Icon(icon, color: iconColor, size: 16.sp),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  label,
                  style: font10w400.copyWith(color: const Color(0xFF94A3B8)),
                ),
                AppText(
                  value,
                  style: font12w500.copyWith(color: const Color(0xFF334155)),
                ),
                if (accentValue != null)
                  AppText(
                    accentValue!,
                    style: font12w500.copyWith(
                      color: accentValueColor ?? const Color(0xFF10B981),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
