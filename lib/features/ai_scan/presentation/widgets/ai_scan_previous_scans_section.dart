import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/app_date_time.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/ai_scan/presentation/cubit/ai_scan/ai_scan_state.dart';
import 'package:yallakhadra/features/ai_scan/presentation/cubit/ai_scan/ai_scan_cubit.dart';
import 'package:yallakhadra/features/ai_scan/presentation/widgets/ai_scan_scan_history_card.dart';

class AiScanPreviousScansSection extends StatelessWidget {
  const AiScanPreviousScansSection({super.key});

  String _formatScanTime(String value) {
    if (value.trim().isEmpty) {
      return 'Just now';
    }

    try {
      return AppDateTime.timestampToFormatted(value);
    } catch (_) {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiScanCubit, AiScanState>(
      builder: (BuildContext context, AiScanState state) {
        final scans = state.scans;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              'Previous Scans',
              style: font14w700.copyWith(color: const Color(0xFF111827)),
            ),
            SizedBox(height: 10.h),
            if (scans.isEmpty)
              AppText(
                'No scans yet. Capture or upload an image to start.',
                style: font12w400.copyWith(color: const Color(0xFF6B7280)),
              ),
            ...scans.asMap().entries.map((entry) {
              final scan = entry.value;
              final bool isRecyclable = scan.isRecyclable;

              return Padding(
                padding: EdgeInsets.only(
                  bottom: entry.key == scans.length - 1 ? 0 : 10.h,
                ),
                child: AiScanScanHistoryCard(
                  imageUrl: scan.imageUrl,
                  title: scan.predictedType,
                  timeAgo: _formatScanTime(scan.createdAt),
                  resultText: isRecyclable ? 'Recyclable' : 'Non-recyclable',
                  resultIcon: isRecyclable
                      ? Icons.eco_outlined
                      : Icons.warning_amber_rounded,
                  resultTextColor: isRecyclable
                      ? const Color(0xFF0F9F6E)
                      : const Color(0xFFDC2626),
                  resultBackgroundColor: isRecyclable
                      ? const Color(0xFFD1FAE5)
                      : const Color(0xFFFEE2E2),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
