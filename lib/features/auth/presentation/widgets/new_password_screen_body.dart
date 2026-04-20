import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/di/services_locator.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/features/auth/presentation/constants/auth_strings.dart';
import 'package:yallakhadra/features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:yallakhadra/features/auth/presentation/widgets/forget_password_top_bar.dart';
import 'package:yallakhadra/features/auth/presentation/widgets/new_password_card.dart';

class NewPasswordScreenBody extends StatelessWidget {
  const NewPasswordScreenBody({
    required this.email,
    required this.code,
    super.key,
  });

  final String email;
  final String code;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgotPasswordCubit>(
      create: (_) => sl<ForgotPasswordCubit>(),
      child: Container(
        width: double.infinity,
        color: AppColors.authBackground,
        child: SafeArea(
          child: Column(
            children: [
              const ForgetPasswordTopBar(title: AuthStrings.newPasswordTitle),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 24.h,
                    bottom: 20.h,
                  ),
                  child: NewPasswordCard(email: email, code: code),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
