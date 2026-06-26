import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/core/di/services_locator.dart';
import 'package:yallakhadra/features/my_works/presentation/cubit/my_work_details/my_work_details_cubit.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_work_completed_details_body.dart';

class MyWorkCompletedDetailsScreen extends StatelessWidget {
  final int reportId;

  const MyWorkCompletedDetailsScreen({super.key, required this.reportId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) =>
            sl<MyWorkDetailsCubit>()..fetchDetails(reportId),
        child: MyWorkCompletedDetailsBody(reportId: reportId),
      ),
    );
  }
}
