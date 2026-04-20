import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/features/my_works/data/repositories/my_works_repository_impl.dart';
import 'package:yallakhadra/features/my_works/domain/usecases/get_my_work_overview_use_case.dart';
import 'package:yallakhadra/features/my_works/presentation/cubit/my_work_overview/my_work_overview_cubit.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_screen_body.dart';

class MyWorksScreen extends StatelessWidget {
  const MyWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => MyWorkOverviewCubit(
          GetMyWorkOverviewUseCase(MyWorksRepositoryImpl()),
        )..loadOverview(),
        child: const MyWorksScreenBody(),
      ),
    );
  }
}
