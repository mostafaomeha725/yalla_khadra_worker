import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/features/home/domain/entities/home_nearby_report_entity.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_details_body.dart';
import 'package:yallakhadra/features/reports/data/repositories/reports_repository_impl.dart';
import 'package:yallakhadra/features/reports/domain/usecases/assign_report_use_case.dart';
import 'package:yallakhadra/features/reports/presentation/cubit/assign_report_cubit.dart';

class HomeReportDetailsScreen extends StatelessWidget {
  final HomeNearbyReportEntity report;

  const HomeReportDetailsScreen({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) =>
            AssignReportCubit(AssignReportUseCase(ReportsRepositoryImpl())),
        child: HomeReportDetailsBody(report: report),
      ),
    );
  }
}
