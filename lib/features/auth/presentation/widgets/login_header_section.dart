import 'package:flutter/material.dart';

import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/auth/presentation/widgets/logo_header.dart';

class LoginHeaderSection extends StatelessWidget {
  const LoginHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LogoHeader(size: 84),
        verticalSpacing(22),
        AppText(
          'Yalla Khadra',
          alignment: AlignmentDirectional.center,
          style: font24w700.copyWith(color: const Color(0xFF111827)),
        ),
        verticalSpacing(8),
        AppText(
          'Join the green movement',
          alignment: AlignmentDirectional.center,
          style: font16w400.copyWith(color: const Color(0xFF009966)),
        ),
        verticalSpacing(34),
      ],
    );
  }
}
