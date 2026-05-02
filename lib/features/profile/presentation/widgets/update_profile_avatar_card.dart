import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/helpers/helpers.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/app_image.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/profile/presentation/constants/profile_strings.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/update_profile_screen_body.dart';

class UpdateProfileAvatarCard extends StatelessWidget {
  const UpdateProfileAvatarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.profileCardSurface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.profileDivider),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 96.w,
            height: 96.w,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ValueListenableBuilder<String?>(
                  valueListenable:
                      UpdateProfileScreenBody.selectedProfileImagePathNotifier,
                  builder: (context, imagePath, _) {
                    final String resolvedPath = (imagePath ?? '').trim();

                    return Container(
                      width: 96.w,
                      height: 96.w,
                      decoration: BoxDecoration(
                        color: AppColors.authPrimary,
                        borderRadius: BorderRadius.circular(48.r),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.authShadowSoft,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: resolvedPath.isEmpty
                          ? Icon(
                              Icons.person_outline_rounded,
                              size: 52.sp,
                              color: AppColors.authWhite,
                            )
                          : resolvedPath.startsWith('http')
                          ? AppImage(
                              imageUrl: resolvedPath,
                              width: 96.w,
                              height: 96.w,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(resolvedPath),
                              width: 96.w,
                              height: 96.w,
                              fit: BoxFit.cover,
                            ),
                    );
                  },
                ),
                PositionedDirectional(
                  end: -2.w,
                  bottom: -2.h,
                  child: BounceIt(
                    onPressed: () async {
                      final file = await Helpers.pickImageFromGallery();
                      if (file == null) {
                        return;
                      }
                      UpdateProfileScreenBody
                              .selectedProfileImagePathNotifier
                              .value =
                          file.path;
                    },
                    child: Container(
                      width: 30.w,
                      height: 30.w,
                      decoration: BoxDecoration(
                        color: AppColors.authPrimary,
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(
                          color: AppColors.authWhite,
                          width: 2.w,
                        ),
                      ),
                      child: Icon(
                        Icons.photo_camera_outlined,
                        size: 16.sp,
                        color: AppColors.authWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          verticalSpacing(12),
          AppText(
            ProfileStrings.profileAvatarHint,
            alignment: AlignmentDirectional.center,
            textAlign: TextAlign.center,
            style: font12w400.copyWith(color: AppColors.profileFooterText),
          ),
        ],
      ),
    );
  }
}
