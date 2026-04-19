import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/widgets/app_form_field.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';

class LoginPasswordField extends StatefulWidget {
  const LoginPasswordField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<LoginPasswordField> createState() => LoginPasswordFieldState();
}

class LoginPasswordFieldState extends State<LoginPasswordField> {
  final ValueNotifier<bool> obscurePasswordNotifier = ValueNotifier<bool>(true);

  @override
  void dispose() {
    obscurePasswordNotifier.dispose();
    super.dispose();
  }

  void toggleVisibility() {
    obscurePasswordNotifier.value = !obscurePasswordNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscurePasswordNotifier,
      builder: (context, obscurePassword, child) {
        return AppFormField(
          controller: widget.controller,
          hintText: '••••••••',
          obsecureText: obscurePassword,
          textInputAction: TextInputAction.done,
          fillColor: const Color(0xFFF3F4F6),
          borderColor: const Color(0xFFE5E7EB),
          radius: 14.r,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 14.h,
          ),
          prefixIcon: Icon(
            Icons.lock_outline_rounded,
            size: 20.sp,
            color: const Color(0xFF98A2B3),
          ),
          suffixIcon: BounceIt(
            onPressed: toggleVisibility,
            child: Padding(
              padding: EdgeInsets.all(12.h),
              child: Icon(
                obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 20.sp,
                color: const Color(0xFF98A2B3),
              ),
            ),
          ),
        );
      },
    );
  }
}
