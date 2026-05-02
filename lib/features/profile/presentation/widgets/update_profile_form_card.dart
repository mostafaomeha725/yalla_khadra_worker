import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/cache/preferences_storage.dart';
import 'package:yallakhadra/core/cache/preferences_storage_keys.dart';
import 'package:yallakhadra/core/di/services_locator.dart' as di;
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/easy_loading.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/app_form_field.dart';
import 'package:yallakhadra/core/widgets/custom_button.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/profile/presentation/constants/profile_strings.dart';
import 'package:yallakhadra/features/profile/presentation/cubit/update_profile_cubit.dart';
import 'package:yallakhadra/features/profile/presentation/cubit/update_profile_state.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/profile_summary_card.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/update_profile_screen_body.dart';

class UpdateProfileFormCard extends StatefulWidget {
  const UpdateProfileFormCard({super.key});

  @override
  State<UpdateProfileFormCard> createState() => UpdateProfileFormCardState();
}

class UpdateProfileFormCardState extends State<UpdateProfileFormCard> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  bool isEditingFirstName = false;
  bool isEditingLastName = false;
  bool isEditingPhone = false;
  bool isEditingAddress = false;

  @override
  void initState() {
    super.initState();
    final prefs = di.sl<PreferencesStorage>();
    firstNameController.text = prefs.getFirstName();
    lastNameController.text = prefs.getLastName();
    phoneController.text = prefs.getString(key: PreferencesKeys.phone) ?? '';
    addressController.text = prefs.getAddress();
    if ((UpdateProfileScreenBody.selectedProfileImagePathNotifier.value ?? '')
        .trim()
        .isEmpty) {
      UpdateProfileScreenBody.selectedProfileImagePathNotifier.value = prefs
          .getString(key: PreferencesKeys.picture);
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileLoading) {
          showLoading(status: 'Updating profile...', userInteractions: false);
        }
        if (state is UpdateProfileError) {
          hideLoading();
          showError(state.message);
        }
        if (state is UpdateProfileSuccess) {
          hideLoading();
          showSuccess(state.message);
          ProfileSummaryCard.profileRefreshNotifier.value++;
        }
      },
      builder: (context, state) {
        final bool isLoading = state is UpdateProfileLoading;

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
                readOnly: !isEditingFirstName,
                suffixIcon: _buildEditSuffix(
                  isEditing: isEditingFirstName,
                  onTap: () {
                    setState(() {
                      isEditingFirstName = !isEditingFirstName;
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
                controller: lastNameController,
                hintText: ProfileStrings.lastNameHint,
                readOnly: !isEditingLastName,
                suffixIcon: _buildEditSuffix(
                  isEditing: isEditingLastName,
                  onTap: () {
                    setState(() {
                      isEditingLastName = !isEditingLastName;
                    });
                  },
                ),
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
                keyboardType: TextInputType.phone,
                readOnly: !isEditingPhone,
                suffixIcon: _buildEditSuffix(
                  isEditing: isEditingPhone,
                  onTap: () {
                    setState(() {
                      isEditingPhone = !isEditingPhone;
                    });
                  },
                ),
              ),
              verticalSpacing(10),
              AppText(
                'Address',
                style: font14w500.copyWith(color: AppColors.authLabel),
              ),
              verticalSpacing(6),
              AppFormField(
                controller: addressController,
                hintText: 'Enter your address',
                readOnly: !isEditingAddress,
                suffixIcon: _buildEditSuffix(
                  isEditing: isEditingAddress,
                  onTap: () {
                    setState(() {
                      isEditingAddress = !isEditingAddress;
                    });
                  },
                ),
              ),
              verticalSpacing(16),
              AppButton(
                text: ProfileStrings.saveChangesButton,
                onPressed: isLoading
                    ? null
                    : () {
                        final prefs = di.sl<PreferencesStorage>();
                        context.read<UpdateProfileCubit>().updateProfile(
                          userId: prefs.getUserId(),
                          firstName: firstNameController.text.trim(),
                          lastName: lastNameController.text.trim(),
                          address: addressController.text.trim(),
                          phoneNumber: phoneController.text.trim(),
                          profileImagePath: UpdateProfileScreenBody
                              .selectedProfileImagePathNotifier
                              .value,
                        );
                        setState(() {
                          isEditingFirstName = false;
                          isEditingLastName = false;
                          isEditingPhone = false;
                          isEditingAddress = false;
                        });
                      },
                color: AppColors.authPrimary,
                textColor: Colors.white,
                textSize: 16.sp,
                textWeight: FontWeight.w600,
                radius: 12.r,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEditSuffix({
    required bool isEditing,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Icon(
          isEditing ? Icons.close_rounded : Icons.edit_rounded,
          color: isEditing ? Colors.red : AppColors.authPrimary,
          size: 18.sp,
        ),
      ),
    );
  }
}
