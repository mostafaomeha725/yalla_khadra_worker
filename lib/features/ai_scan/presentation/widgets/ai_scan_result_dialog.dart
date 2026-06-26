import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/app_image.dart';
import 'package:yallakhadra/core/widgets/custom_button.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/ai_scan/domain/entities/ai_scan_result_entity.dart';
import 'package:yallakhadra/features/ai_scan/presentation/widgets/ai_scan_result_chip.dart';

class AiScanResultDialog extends StatelessWidget {
  final AiScanResultEntity scan;

  const AiScanResultDialog({super.key, required this.scan});

  static void show(BuildContext context, AiScanResultEntity scan) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => AiScanResultDialog(scan: scan),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isRecyclable = scan.isRecyclable;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    'Scan Result',
                    style: font16w700.copyWith(color: const Color(0xFF111827)),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3F4F6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 20.w,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpacing(24),

              // Image
              AppImage(
                imageUrl: scan.imageUrl,
                width: 180.w,
                height: 180.w,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(16.r),
              ),
              verticalSpacing(20),

              // Result Chip
              AiScanResultChip(
                text: isRecyclable ? 'Recyclable' : 'Non-recyclable',
                icon: isRecyclable
                    ? Icons.check_circle_outline
                    : Icons.warning_amber_rounded,
                textColor: isRecyclable
                    ? const Color(0xFF0F9F6E)
                    : const Color(0xFFDC2626),
                backgroundColor: isRecyclable
                    ? const Color(0xFFD1FAE5)
                    : const Color(0xFFFEE2E2),
              ),
              verticalSpacing(16),

              // Title
              AppText(
                scan.predictedType.trim().isEmpty
                    ? 'Unknown Waste Type'
                    : scan.predictedType,
                style: font20w700.copyWith(color: const Color(0xFF111827)),
                textAlign: TextAlign.center,
                alignment: AlignmentDirectional.center,
              ),
              verticalSpacing(24),

              // AI Explanation Box
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.eco_outlined,
                          size: 18.w,
                          color: const Color(0xFF0F9F6E),
                        ),
                        horizontalSpacing(8),
                        AppText(
                          'AI Explanation',
                          style: font14w700.copyWith(
                            color: const Color(0xFF111827),
                          ),
                        ),
                      ],
                    ),
                    verticalSpacing(8),
                    AppText(
                      scan.explanation.trim().isEmpty
                          ? 'No explanation available.'
                          : scan.explanation,
                      style: font12w400.copyWith(
                        color: const Color(0xFF4B5563),
                        height: 1.5,
                      ),
                      maxLines: 6,
                    ),
                  ],
                ),
              ),
              verticalSpacing(24),

              // Button
              AppButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                textSize: 16.sp,
                text: 'Scan Another Item',
                radius: 12.r,
                color: AppColors.authPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
