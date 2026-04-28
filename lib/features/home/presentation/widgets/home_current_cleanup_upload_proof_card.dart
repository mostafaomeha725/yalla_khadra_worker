import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_cleanup_media_action_button.dart';

class HomeCurrentCleanupUploadProofCard extends StatelessWidget {
  final VoidCallback onCameraPressed;
  final VoidCallback onGalleryPressed;
  final List<String> selectedImagePaths;
  final ValueChanged<int> onRemoveImage;

  const HomeCurrentCleanupUploadProofCard({
    super.key,
    required this.onCameraPressed,
    required this.onGalleryPressed,
    required this.selectedImagePaths,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'Upload Cleanup Proof',
            style: font16w700.copyWith(color: const Color(0xFF1E293B)),
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              HomeCleanupMediaActionButton(
                text: 'Camera',
                icon: Icons.photo_camera_outlined,
                iconColor: const Color(0xFF059669),
                backgroundColor: const Color(0xFFF0FDF4),
                borderColor: const Color(0xFF6EE7B7),
                textColor: const Color(0xFF059669),
                onPressed: onCameraPressed,
              ),
              horizontalSpacing(12),
              HomeCleanupMediaActionButton(
                text: 'Gallery',
                icon: Icons.file_upload_outlined,
                iconColor: const Color(0xFF2563EB),
                backgroundColor: const Color(0xFFEFF6FF),
                borderColor: const Color(0xFF93C5FD),
                textColor: const Color(0xFF2563EB),
                onPressed: onGalleryPressed,
              ),
            ],
          ),
          if (selectedImagePaths.isNotEmpty) ...[
            SizedBox(height: 12.h),
            SizedBox(
              height: 84.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: selectedImagePaths.length,
                separatorBuilder: (context, index) => SizedBox(width: 8.w),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.file(
                          File(selectedImagePaths[index]),
                          width: 84.w,
                          height: 84.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 4.h,
                        right: 4.w,
                        child: GestureDetector(
                          onTap: () => onRemoveImage(index),
                          child: Container(
                            width: 22.w,
                            height: 22.h,
                            decoration: const BoxDecoration(
                              color: Color(0xCC0F172A),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
