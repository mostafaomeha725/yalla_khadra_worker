import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/cache/preferences_storage.dart';
import 'package:yallakhadra/core/cache/preferences_storage_keys.dart';
import 'package:yallakhadra/core/di/services_locator.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/app_brand_header.dart';
import 'package:yallakhadra/features/profile/presentation/constants/profile_strings.dart';
import 'package:yallakhadra/features/profile/presentation/cubit/update_profile_cubit.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/change_password_title_bar.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/update_profile_avatar_card.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/update_profile_form_card.dart';

class UpdateProfileScreenBody extends StatelessWidget {
  const UpdateProfileScreenBody({super.key});

  static final ValueNotifier<String?> selectedProfileImagePathNotifier =
      ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    final PreferencesStorage preferencesStorage = sl<PreferencesStorage>();
    if ((selectedProfileImagePathNotifier.value ?? '').trim().isEmpty) {
      selectedProfileImagePathNotifier.value = preferencesStorage.getString(
        key: PreferencesKeys.picture,
      );
    }

    return BlocProvider<UpdateProfileCubit>(
      create: (_) => sl<UpdateProfileCubit>(),
      child: Container(
        width: double.infinity,
        color: AppColors.profileBackground,
        child: SafeArea(
          child: Column(
            children: [
              const AppBrandHeader(),
              const Divider(height: 1, color: AppColors.profileDivider),
              const ChangePasswordTitleBar(
                title: ProfileStrings.updateProfileTitle,
              ),
              const Divider(height: 1, color: AppColors.profileDivider),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 14.h,
                  ),
                  child: Column(
                    children: [
                      const UpdateProfileAvatarCard(),
                      verticalSpacing(12),
                      const UpdateProfileFormCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
