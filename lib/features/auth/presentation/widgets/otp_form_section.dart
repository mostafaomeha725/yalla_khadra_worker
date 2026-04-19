import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/helpers/helpers.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_button.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/auth/presentation/constants/auth_strings.dart';
import 'package:yallakhadra/features/auth/presentation/widgets/otp_code_fields_row.dart';

class OtpFormSection extends StatefulWidget {
  const OtpFormSection({super.key});

  @override
  State<OtpFormSection> createState() => OtpFormSectionState();
}

class OtpFormSectionState extends State<OtpFormSection> {
  final List<TextEditingController> codeControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> codeFocusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final controller in codeControllers) {
      controller.dispose();
    }
    for (final focusNode in codeFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OtpCodeFieldsRow(
          controllers: codeControllers,
          focusNodes: codeFocusNodes,
        ),
        verticalSpacing(26),
        AppButton(
          text: AuthStrings.otpVerifyButton,
          onPressed: () => Helpers.handleVerifyOtp(
            context: context,
            otpCode: codeControllers.map((e) => e.text.trim()).join(),
          ),
          color: AppColors.authPrimary,
          textColor: Colors.white,
          textSize: 16.sp,
          textWeight: FontWeight.w600,
          radius: 14.r,
        ),
        verticalSpacing(24),
        AppText(
          AuthStrings.otpDidNotReceive,
          alignment: AlignmentDirectional.center,
          style: font16w400.copyWith(color: AppColors.authSubText),
        ),
        verticalSpacing(10),
        Center(
          child: BounceIt(
            onPressed: () => Helpers.handleResendOtp(context),
            child: AppText(
              AuthStrings.otpResendCode,
              alignment: AlignmentDirectional.center,
              style: font18w500.copyWith(color: AppColors.authAccent),
            ),
          ),
        ),
      ],
    );
  }
}
