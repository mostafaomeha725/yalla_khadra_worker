import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/core/theme/light_colors.dart';
import 'package:yallakhadra/core/widgets/app_brand_header.dart';
import 'package:yallakhadra/core/widgets/custom_loading.dart';
import 'package:yallakhadra/features/home/presentation/cubit/home_cubit.dart';
import 'package:yallakhadra/features/home/presentation/cubit/home_state.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_dashboard_content.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppLightColors.defaultBackground,
      width: double.infinity,
      child: SafeArea(
        child: Column(
          children: [
            const AppBrandHeader(),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading || state is HomeInitial) {
                    return CustomLoading.showLoader();
                  }

                  if (state is HomeLoaded) {
                    return HomeDashboardContent(dashboard: state.dashboard);
                  }

                  if (state is HomeError) {
                    return HomeDashboardContent.error(message: state.message);
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
