import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/features/ai_scan/presentation/widgets/ai_scan_action_card.dart';

class AiScanActionCardsSection extends StatelessWidget {
  const AiScanActionCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AiScanActionCard(
          icon: Icons.photo_camera_outlined,
          title: 'Capture',
          subtitle: 'Take a photo with camera',
          backgroundColor: Color(0xFF10B981),
          titleColor: Color(0xFFFFFFFF),
          subtitleColor: Color(0xFFBBF7D0),
          iconColor: Color(0xFFFFFFFF),
          borderColor: Color(0xFF10B981),
          borderWidth: 1,
          radius: 13,
          height: 142.h,
          iconSize: 40.sp,
          titleSize: 20.sp,
          subtitleSize: 11.sp,
          boxShadow: [
            BoxShadow(
              color: Color(0x2210B981),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        AiScanActionCard(
          icon: Icons.upload_rounded,
          title: 'Upload',
          subtitle: 'Choose from gallery',
          backgroundColor: Color(0xFFDCE9E4),
          titleColor: Color(0xFF1F2937),
          subtitleColor: Color(0xFF6B7280),
          iconColor: Color(0xFF10B981),
          borderColor: Color(0xFF8DE9BD),
          borderWidth: 1.2,
          radius: 13,
          height: 142.h,
          iconSize: 44.sp,
          titleSize: 20.sp,
          subtitleSize: 11.sp,
        ),
      ],
    );
  }
}
