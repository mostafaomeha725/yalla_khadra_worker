import 'package:flutter/material.dart';
import 'package:yallakhadra/features/auth/presentation/widgets/new_password_screen_body.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({required this.email, required this.code, super.key});

  final String email;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NewPasswordScreenBody(email: email, code: code),
    );
  }
}
