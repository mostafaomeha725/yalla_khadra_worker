import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/cache/preferences_storage.dart';
import 'package:yallakhadra/core/cache/preferences_storage_keys.dart';
import 'package:yallakhadra/core/di/services_locator.dart' as di;
import 'package:yallakhadra/core/helpers/helpers.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/easy_loading.dart';
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

  final FocusNode firstNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();

  bool isEditingFirstName = false;
  bool isEditingLastName = false;
  bool isEditingEmail = false;
  bool isEditingPhone = false;

  bool get isEditingAny =>
      isEditingFirstName ||
      isEditingLastName ||
      isEditingEmail ||
      isEditingPhone;

  @override
  void initState() {
    super.initState();
    final prefs = di.sl<PreferencesStorage>();
    firstNameController.text = prefs.getFirstName();
    lastNameController.text = prefs.getLastName();
    emailController.text = prefs.getEmail();
    phoneController.text = prefs.getString(key: PreferencesKeys.phone) ?? '';
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    firstNameFocus.dispose();
    lastNameFocus.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
    super.dispose();
  }

  Widget _buildEditSuffix({
    required bool isEditing,
    required VoidCallback onEditTap,
  }) {
    return GestureDetector(
      onTap: onEditTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 14.w),
        child: Icon(
          isEditing ? Icons.close_rounded : Icons.edit_rounded,
          size: 18.sp,
          color: isEditing ? Colors.red : AppColors.authPrimary,
        ),
      ),
    );
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
            focusNode: firstNameFocus,
            readOnly: !isEditingFirstName,
            controller: firstNameController,
            hintText: ProfileStrings.firstNameHint,
            fillColor: isEditingFirstName
                ? AppColors.authFieldFill
                : AppColors.profileDivider.withValues(alpha: 0.3),
            borderColor: isEditingFirstName
                ? AppColors.authFieldBorder
                : Colors.transparent,
            hintColor: AppColors.authMutedIcon,
            radius: 12.r,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 12.h,
            ),
            suffixIcon: _buildEditSuffix(
              isEditing: isEditingFirstName,
              onEditTap: () {
                setState(() {
                  isEditingFirstName = !isEditingFirstName;
                  if (isEditingFirstName) {
                    firstNameFocus.requestFocus();
                  } else {
                    final prefs = di.sl<PreferencesStorage>();
                    firstNameController.text = prefs.getFirstName();
                  }
                });
              },
            ),
          ),
          verticalSpacing(10),
          AppText(
            ProfileStrings.lastNameLabel,
            style: font14w500.copyWith(color: AppColors.authLabel),
          ),
          verticalSpacing(6),
          AppFormField(
            focusNode: lastNameFocus,
            readOnly: !isEditingLastName,
            controller: lastNameController,
            hintText: ProfileStrings.lastNameHint,
            fillColor: isEditingLastName
                ? AppColors.authFieldFill
                : AppColors.profileDivider.withValues(alpha: 0.3),
            borderColor: isEditingLastName
                ? AppColors.authFieldBorder
                : Colors.transparent,
            hintColor: AppColors.authMutedIcon,
            radius: 12.r,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 12.h,
            ),
            suffixIcon: _buildEditSuffix(
              isEditing: isEditingLastName,
              onEditTap: () {
                setState(() {
                  isEditingLastName = !isEditingLastName;
                  if (isEditingLastName) {
                    lastNameFocus.requestFocus();
                  } else {
                    final prefs = di.sl<PreferencesStorage>();
                    lastNameController.text = prefs.getLastName();
                  }
                });
              },
            ),
          ),
          verticalSpacing(10),
          AppText(
            ProfileStrings.emailLabel,
            style: font14w500.copyWith(color: AppColors.authLabel),
          ),
          verticalSpacing(6),
          AppFormField(
            focusNode: emailFocus,
            readOnly: !isEditingEmail,
            controller: emailController,
            hintText: ProfileStrings.emailHint,
            fillColor: isEditingEmail
                ? AppColors.authFieldFill
                : AppColors.profileDivider.withValues(alpha: 0.3),
            borderColor: isEditingEmail
                ? AppColors.authFieldBorder
                : Colors.transparent,
            hintColor: AppColors.authMutedIcon,
            radius: 12.r,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 12.h,
            ),
            keyboardType: TextInputType.emailAddress,
            suffixIcon: _buildEditSuffix(
              isEditing: isEditingEmail,
              onEditTap: () {
                setState(() {
                  isEditingEmail = !isEditingEmail;
                  if (isEditingEmail) {
                    emailFocus.requestFocus();
                  } else {
                    final prefs = di.sl<PreferencesStorage>();
                    emailController.text = prefs.getEmail();
                  }
                });
              },
            ),
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
            focusNode: phoneFocus,
            readOnly: !isEditingPhone,
            controller: phoneController,
            hintText: ProfileStrings.phoneHint,
            fillColor: isEditingPhone
                ? AppColors.authFieldFill
                : AppColors.profileDivider.withValues(alpha: 0.3),
            borderColor: isEditingPhone
                ? AppColors.authFieldBorder
                : Colors.transparent,
            hintColor: AppColors.authMutedIcon,
            radius: 12.r,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 12.h,
            ),
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            suffixIcon: _buildEditSuffix(
              isEditing: isEditingPhone,
              onEditTap: () {
                setState(() {
                  isEditingPhone = !isEditingPhone;
                  if (isEditingPhone) {
                    phoneFocus.requestFocus();
                  } else {
                    final prefs = di.sl<PreferencesStorage>();
                    phoneController.text =
                        prefs.getString(key: PreferencesKeys.phone) ?? '';
                  }
                });
              },
            ),
          ),
          verticalSpacing(16),
          if (isEditingAny) ...[
            AppButton(
              text: ProfileStrings.saveChangesButton,
              onPressed: () {
                setState(() {
                  isEditingFirstName = false;
                  isEditingLastName = false;
                  isEditingEmail = false;
                  isEditingPhone = false;
                });
                // Validation call removed as requested
                final prefs = di.sl<PreferencesStorage>();
                prefs.saveUserProfile(
                  firstName: firstNameController.text.trim(),
                  lastName: lastNameController.text.trim(),
                  email: emailController.text.trim(),
                );
                prefs.putString(
                  key: PreferencesKeys.phone,
                  value: phoneController.text.trim(),
                );

                // Show success directly
                showSuccess('Profile updated successfully.');
              },
              color: AppColors.authPrimary,
              textColor: Colors.white,
              textSize: 16.sp,
              textWeight: FontWeight.w600,
              radius: 12.r,
            ),
            verticalSpacing(8),
            AppButton(
              text: ProfileStrings.cancelEditButton,
              onPressed: () {
                setState(() {
                  isEditingFirstName = false;
                  isEditingLastName = false;
                  isEditingEmail = false;
                  isEditingPhone = false;
                });
                final prefs = di.sl<PreferencesStorage>();
                firstNameController.text = prefs.getFirstName();
                lastNameController.text = prefs.getLastName();
                emailController.text = prefs.getEmail();
                phoneController.text =
                    prefs.getString(key: PreferencesKeys.phone) ?? '';
              },
              color: AppColors.profileDivider,
              textColor: AppColors.authLabel,
              textSize: 16.sp,
              textWeight: FontWeight.w600,
              radius: 12.r,
            ),
          ],
        ],
      ),
    );
  }
}
