import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/utils/easy_loading.dart';
import 'package:yallakhadra/features/ai_scan/presentation/cubit/ai_scan/ai_scan_cubit.dart';
import 'package:yallakhadra/features/ai_scan/presentation/widgets/ai_scan_action_card.dart';
import 'package:image_picker/image_picker.dart';

class AiScanActionCardsSection extends StatelessWidget {
  const AiScanActionCardsSection({super.key});

  Future<void> _pickAndScan(BuildContext context, ImageSource source) async {
    final AiScanCubit cubit = context.read<AiScanCubit>();
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image == null) {
      showError('No image selected.');
      return;
    }

    cubit.selectImage(image.path);
    await cubit.scanSelectedImage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AiScanActionCard(
          onPressed: () {
            _pickAndScan(context, ImageSource.camera);
          },
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
          onPressed: () {
            _pickAndScan(context, ImageSource.gallery);
          },
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
