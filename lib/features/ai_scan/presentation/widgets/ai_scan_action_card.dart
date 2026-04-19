import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class AiScanActionCard extends StatelessWidget {
  const AiScanActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
    required this.iconColor,
    required this.borderColor,
    this.borderWidth = 1,
    this.radius,
    this.height,
    this.iconSize,
    this.titleSize,
    this.subtitleSize,
    this.contentPadding,
    this.boxShadow,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Color iconColor;
  final Color borderColor;
  final double borderWidth;
  final double? radius;
  final double? height;
  final double? iconSize;
  final double? titleSize;
  final double? subtitleSize;
  final EdgeInsetsGeometry? contentPadding;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return BounceIt(
      onPressed: () {},
      child: Container(
        width: double.infinity,
        constraints: height == null ? null : BoxConstraints(minHeight: height!),
        padding:
            contentPadding ??
            EdgeInsets.symmetric(vertical: 18.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius ?? 12.r),
          border: Border.all(color: borderColor, width: borderWidth),
          boxShadow: boxShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: iconSize ?? 34.sp, color: iconColor),
            SizedBox(height: 8.h),
            AppText(
              title,
              alignment: AlignmentDirectional.center,
              style: TextStyle(
                color: titleColor,
                fontWeight: FontWeight.w700,
                fontSize: titleSize ?? 22.sp,
              ),
            ),
            SizedBox(height: 4.h),
            AppText(
              subtitle,
              alignment: AlignmentDirectional.center,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: subtitleColor,
                fontWeight: FontWeight.w500,
                fontSize: subtitleSize ?? 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
