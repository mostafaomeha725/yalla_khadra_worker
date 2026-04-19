import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/features/ai_scan/presentation/widgets/ai_scan_action_cards_section.dart';
import 'package:yallakhadra/features/ai_scan/presentation/widgets/ai_scan_hero_section.dart';
import 'package:yallakhadra/features/ai_scan/presentation/widgets/ai_scan_previous_scans_section.dart';

class AiScanContentSection extends StatelessWidget {
  const AiScanContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(22.w, 10.h, 22.w, 110.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AiScanHeroSection(),
          SizedBox(height: 12.h),
          const AiScanActionCardsSection(),
          SizedBox(height: 12.h),
          const AiScanPreviousScansSection(),
        ],
      ),
    );
  }
}
