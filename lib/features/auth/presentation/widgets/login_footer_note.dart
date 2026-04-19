import 'package:flutter/material.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class LoginFooterNote extends StatelessWidget {
  const LoginFooterNote({super.key});

  @override
  Widget build(BuildContext context) {
    return AppText(
      'For authorized workers only',
      alignment: AlignmentDirectional.center,
      style: font12w400.copyWith(color: const Color(0xFF6B7280)),
    );
  }
}
