import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/core/theme/light_colors.dart';
import 'package:yallakhadra/core/widgets/app_brand_header.dart';
import 'package:yallakhadra/core/widgets/custom_loading.dart';
import 'package:yallakhadra/features/my_works/presentation/cubit/my_work_overview/my_work_overview_cubit.dart';
import 'package:yallakhadra/features/my_works/presentation/cubit/my_work_overview/my_work_overview_state.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_content_section.dart';

class MyWorksScreenBody extends StatelessWidget {
  const MyWorksScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppLightColors.defaultBackground,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const AppBrandHeader(),
            Expanded(
              child: BlocBuilder<MyWorkOverviewCubit, MyWorkOverviewState>(
                builder: (context, state) {
                  if (state is MyWorkOverviewInitial ||
                      state is MyWorkOverviewLoading) {
                    return CustomLoading.showLoader();
                  }

                  if (state is MyWorkOverviewLoaded) {
                    return MyWorksContentSection(
                      overview: state.overview,
                      reportsPage: state.reportsPage,
                    );
                  }

                  if (state is MyWorkOverviewError) {
                    return MyWorksContentSection.error(message: state.message);
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
