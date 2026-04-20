import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/core/di/services_locator.dart';
import 'package:yallakhadra/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:yallakhadra/features/auth/presentation/widgets/login_screen_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (_) => sl<LoginCubit>(),
      child: const Scaffold(body: LoginScreenBody()),
    );
  }
}
