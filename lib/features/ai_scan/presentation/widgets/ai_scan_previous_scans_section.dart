import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/ai_scan/presentation/widgets/ai_scan_scan_history_card.dart';

class AiScanPreviousScansSection extends StatelessWidget {
  const AiScanPreviousScansSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'Previous Scans',
          style: font14w700.copyWith(color: const Color(0xFF111827)),
        ),
        SizedBox(height: 10.h),
        const AiScanScanHistoryCard(
          imageUrl: 'https://picsum.photos/id/292/200/200',
          title: 'Plastic Bottle',
          timeAgo: '1d ago',
          resultText: 'Recyclable',
          resultIcon: Icons.eco_outlined,
          resultTextColor: Color(0xFF0F9F6E),
          resultBackgroundColor: Color(0xFFD1FAE5),
        ),
        SizedBox(height: 10.h),
        const AiScanScanHistoryCard(
          imageUrl: 'https://picsum.photos/id/237/200/200',
          title: 'Mixed Waste',
          timeAgo: '2d ago',
          resultText: 'Non-recyclable',
          resultIcon: Icons.warning_amber_rounded,
          resultTextColor: Color(0xFFDC2626),
          resultBackgroundColor: Color(0xFFFEE2E2),
        ),
      ],
    );
  }
}
