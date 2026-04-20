import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yallakhadra/core/routes/route_paths.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/bouncing_social_button.dart';
import 'package:yallakhadra/core/widgets/custom_loading.dart';
import 'package:yallakhadra/core/widgets/custom_snack_bar.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/profile/presentation/cubit/profile_logout_cubit.dart';
import 'package:yallakhadra/features/profile/presentation/cubit/profile_logout_state.dart';
import 'package:yallakhadra/features/profile/presentation/constants/profile_strings.dart';

class ProfileLogoutSection extends StatelessWidget {
  const ProfileLogoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileLogoutCubit, ProfileLogoutState>(
      listener: (BuildContext context, ProfileLogoutState state) {
        if (state is ProfileLogoutError) {
          CustomSnackBar.showError(context, message: state.message);
        }

        if (state is ProfileLogoutSuccess) {
          CustomSnackBar.showSuccess(context, message: state.message);
          context.go(Routes.loginScreen);
        }
      },
      builder: (BuildContext context, ProfileLogoutState state) {
        final bool isLoading = state is ProfileLogoutLoading;

        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 8.h),
                BouncingSocialButton(
                  text: ProfileStrings.logoutButton,
                  onTap: isLoading
                      ? null
                      : () => context.read<ProfileLogoutCubit>().logout(),
                  textColor: const Color(0xFFE53E3E),
                  color: const Color(0xFFFFF0F0),
                  radius: 20.r,
                  height: 52.h,
                  textSize: 16.sp,
                  borderColor: const Color(0x66E53E3E),
                  leading: Icon(
                    Icons.logout,
                    size: 18.sp,
                    color: const Color(0xFFE53E3E),
                  ),
                ),
                verticalSpacing(12),
                AppText(
                  ProfileStrings.appVersionLabel,
                  alignment: AlignmentDirectional.center,
                  style: font14w400.copyWith(
                    color: AppColors.profileVersionText,
                  ),
                ),
              ],
            ),
            if (isLoading) CustomLoading.showLoader(),
          ],
        );
      },
    );
  }
}
