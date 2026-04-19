import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/widgets/app_form_field.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';

class ProfilePasswordField extends StatefulWidget {
  const ProfilePasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    this.textInputAction = TextInputAction.next,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputAction textInputAction;

  @override
  State<ProfilePasswordField> createState() => ProfilePasswordFieldState();
}

class ProfilePasswordFieldState extends State<ProfilePasswordField> {
  final ValueNotifier<bool> obscurePasswordNotifier = ValueNotifier<bool>(true);

  @override
  void dispose() {
    obscurePasswordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscurePasswordNotifier,
      builder: (context, obscurePassword, child) {
        return AppFormField(
          controller: widget.controller,
          hintText: widget.hintText,
          obsecureText: obscurePassword,
          textInputAction: widget.textInputAction,
          fillColor: AppColors.authFieldFill,
          borderColor: AppColors.authFieldBorder,
          radius: 14.r,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 14.h,
          ),
          prefixIcon: Icon(
            Icons.lock_outline_rounded,
            size: 20.sp,
            color: AppColors.authMutedIcon,
          ),
          suffixIcon: BounceIt(
            onPressed: () {
              obscurePasswordNotifier.value = !obscurePassword;
            },
            child: Padding(
              padding: EdgeInsets.all(12.h),
              child: Icon(
                obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 20.sp,
                color: AppColors.authMutedIcon,
              ),
            ),
          ),
        );
      },
    );
  }
}
