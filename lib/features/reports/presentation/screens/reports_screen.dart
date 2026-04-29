import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/features/reports/data/repositories/reports_repository_impl.dart';
import 'package:yallakhadra/features/reports/domain/usecases/get_nearby_reports_use_case.dart';
import 'package:yallakhadra/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:yallakhadra/features/reports/presentation/widgets/reports_content_section.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => ReportsCubit(
          GetNearbyReportsUseCase(ReportsRepositoryImpl()),
          useRadiusByDefault: true,
        )..loadReports(),
        child: const ReportsContentSection(),
      ),
    );
  }
}
