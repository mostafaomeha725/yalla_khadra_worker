import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/core/cache/preferences_storage.dart';
import 'package:yallakhadra/core/di/services_locator.dart';
import 'package:yallakhadra/features/home/data/repositories/home_repository_impl.dart';
import 'package:yallakhadra/features/home/domain/usecases/complete_cleanup_task_use_case.dart';
import 'package:yallakhadra/features/home/domain/usecases/get_home_dashboard_use_case.dart';
import 'package:yallakhadra/features/home/domain/usecases/update_user_location_use_case.dart';
import 'package:yallakhadra/features/home/presentation/cubit/home_cubit.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => HomeCubit(
          getHomeDashboardUseCase: GetHomeDashboardUseCase(
            HomeRepositoryImpl(),
          ),
          completeCleanupTaskUseCase: CompleteCleanupTaskUseCase(
            HomeRepositoryImpl(),
          ),
          updateUserLocationUseCase: UpdateUserLocationUseCase(
            HomeRepositoryImpl(),
          ),
          preferencesStorage: sl<PreferencesStorage>(),
        )..loadDashboard(),
        child: const HomeScreenBody(),
      ),
    );
  }
}
