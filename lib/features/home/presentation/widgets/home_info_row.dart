import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class HomeInfoRow extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color iconColor;
  final Color textColor;
  final double? iconSize;
  final double? textSize;
  final FontWeight? textWeight;

  const HomeInfoRow({
    super.key,
    required this.icon,
    required this.value,
    required this.iconColor,
    required this.textColor,
    this.iconSize,
    this.textSize,
    this.textWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: iconSize ?? 16.sp),
        horizontalSpacing(8),
        Expanded(
          child: AppText(
            value,
            maxLines: 1,
            style: TextStyle(
              color: textColor,
              fontSize: textSize ?? 14.sp,
              fontWeight: textWeight ?? FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
