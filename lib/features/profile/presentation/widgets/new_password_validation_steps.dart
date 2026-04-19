import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/utils/validators.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/features/profile/presentation/constants/profile_strings.dart';
import 'package:yallakhadra/features/profile/presentation/widgets/password_rule_status_item.dart';

class NewPasswordValidationSteps extends StatelessWidget {
  const NewPasswordValidationSteps({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        final String password = value.text;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.h),
            PasswordRuleStatusItem(
              label: ProfileStrings.passwordRuleMinLength,
              isValid: Validators.hasMinLength(password),
            ),
            verticalSpacing(6),
            PasswordRuleStatusItem(
              label: ProfileStrings.passwordRuleUpperCase,
              isValid: Validators.hasUpperCase(password),
            ),
            verticalSpacing(6),
            PasswordRuleStatusItem(
              label: ProfileStrings.passwordRuleLowerCase,
              isValid: Validators.hasLowerCase(password),
            ),
          ],
        );
      },
    );
  }
}
