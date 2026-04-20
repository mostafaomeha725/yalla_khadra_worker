import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/di/services_locator.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/app_brand_header.dart';
import 'package:yallakhadra/features/profile/presentation/cubit/change_password_cubit.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/change_password_footer_note.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/change_password_form_card.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/change_password_title_bar.dart';

class ChangePasswordScreenBody extends StatelessWidget {
  const ChangePasswordScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordCubit>(
      create: (_) => sl<ChangePasswordCubit>(),
      child: Container(
        width: double.infinity,
        color: AppColors.profileBackground,
        child: SafeArea(
          child: Column(
            children: [
              const AppBrandHeader(),
              const Divider(height: 1, color: AppColors.profileDivider),
              const ChangePasswordTitleBar(),
              const Divider(height: 1, color: AppColors.profileDivider),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    children: [
                      const ChangePasswordFormCard(),
                      verticalSpacing(12),
                      const ChangePasswordFooterNote(),
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
