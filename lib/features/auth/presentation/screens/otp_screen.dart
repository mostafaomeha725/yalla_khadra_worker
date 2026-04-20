import 'package:flutter/material.dart';
import 'package:yallakhadra/features/auth/presentation/widgets/otp_screen_body.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({required this.email, super.key});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OtpScreenBody(email: email));
  }
}
