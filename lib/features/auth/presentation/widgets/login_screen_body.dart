import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/features/auth/presentation/widgets/login_footer_note.dart';
import 'package:yallakhadra/features/auth/presentation/widgets/login_form_section.dart';
import 'package:yallakhadra/features/auth/presentation/widgets/login_header_section.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFDDEBE5),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 18.h),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 360.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 30.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LoginHeaderSection(),
                    LoginFormSection(),
                    SizedBox(height: 8),
                    LoginFooterNote(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
