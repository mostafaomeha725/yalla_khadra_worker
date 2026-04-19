import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/helpers/helpers.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/app_form_field.dart';
import 'package:yallakhadra/core/widgets/custom_button.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/profile/presentation/constants/profile_strings.dart';

class UpdateProfileFormCard extends StatefulWidget {
  const UpdateProfileFormCard({super.key});

  @override
  State<UpdateProfileFormCard> createState() => UpdateProfileFormCardState();
}

class UpdateProfileFormCardState extends State<UpdateProfileFormCard> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.profileCardSurface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.profileDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText(
            ProfileStrings.firstNameLabel,
            style: font14w500.copyWith(color: AppColors.authLabel),
          ),
          verticalSpacing(6),
          AppFormField(
            controller: firstNameController,
            hintText: ProfileStrings.firstNameHint,
            fillColor: AppColors.authFieldFill,
            borderColor: AppColors.authFieldBorder,
            hintColor: AppColors.authMutedIcon,
            radius: 12.r,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 12.h,
            ),
          ),
          verticalSpacing(10),
          AppText(
            ProfileStrings.lastNameLabel,
            style: font14w500.copyWith(color: AppColors.authLabel),
          ),
          verticalSpacing(6),
          AppFormField(
            controller: lastNameController,
            hintText: ProfileStrings.lastNameHint,
            fillColor: AppColors.authFieldFill,
            borderColor: AppColors.authFieldBorder,
            hintColor: AppColors.authMutedIcon,
            radius: 12.r,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 12.h,
            ),
          ),
          verticalSpacing(10),
          AppText(
            ProfileStrings.emailLabel,
            style: font14w500.copyWith(color: AppColors.authLabel),
          ),
          verticalSpacing(6),
          AppFormField(
            controller: emailController,
            hintText: ProfileStrings.emailHint,
            fillColor: AppColors.authFieldFill,
            borderColor: AppColors.authFieldBorder,
            hintColor: AppColors.authMutedIcon,
            radius: 12.r,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 12.h,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          verticalSpacing(4),
          AppText(
            ProfileStrings.emailHelpNote,
            style: font10w400.copyWith(color: AppColors.profileFooterText),
          ),
          verticalSpacing(10),
          AppText(
            ProfileStrings.phoneLabel,
            style: font14w500.copyWith(color: AppColors.authLabel),
          ),
          verticalSpacing(6),
          AppFormField(
            controller: phoneController,
            hintText: ProfileStrings.phoneHint,
            fillColor: AppColors.authFieldFill,
            borderColor: AppColors.authFieldBorder,
            hintColor: AppColors.authMutedIcon,
            radius: 12.r,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 12.h,
            ),
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
          ),
          verticalSpacing(16),
          AppButton(
            text: ProfileStrings.saveChangesButton,
            onPressed: () => Helpers.handleUpdateProfileSave(
              context: context,
              firstName: firstNameController.text.trim(),
              lastName: lastNameController.text.trim(),
              email: emailController.text.trim(),
              phone: phoneController.text.trim(),
            ),
            color: AppColors.authPrimary,
            textColor: Colors.white,
            textSize: 16.sp,
            textWeight: FontWeight.w600,
            radius: 12.r,
          ),
        ],
      ),
    );
  }
}
