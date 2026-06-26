import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/app_image.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/ai_scan/presentation/widgets/ai_scan_result_chip.dart';

class AiScanScanHistoryCard extends StatelessWidget {
  const AiScanScanHistoryCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.timeAgo,
    required this.resultText,
    required this.resultIcon,
    required this.resultTextColor,
    required this.resultBackgroundColor,
    this.onTap,
  });

  final String imageUrl;
  final String title;
  final String timeAgo;
  final String resultText;
  final IconData resultIcon;
  final Color resultTextColor;
  final Color resultBackgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BounceIt(
      onPressed: onTap ?? () {},
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 108.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage(
              imageUrl: imageUrl,
              width: 52.w,
              height: 52.w,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(10.r),
              showprogressIndicator: false,
            ),
            horizontalSpacing(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppText(
                          title,
                          maxLines: 1,
                          style: font14w700.copyWith(
                            color: const Color(0xFF111827),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      AppText(
                        timeAgo,
                        style: font10w500.copyWith(
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  AiScanResultChip(
                    text: resultText,
                    icon: resultIcon,
                    textColor: resultTextColor,
                    backgroundColor: resultBackgroundColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
