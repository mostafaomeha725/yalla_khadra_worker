import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/core/theme/light_colors.dart';
import 'package:yallakhadra/core/utils/easy_loading.dart';
import 'package:yallakhadra/core/widgets/app_brand_header.dart';
import 'package:yallakhadra/features/home/presentation/cubit/home_cubit.dart';
import 'package:yallakhadra/features/home/presentation/cubit/home_state.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_dashboard_content.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_location_banner.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody>
    with WidgetsBindingObserver {
  HomeLocationBannerType? _bannerType;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentState = context.read<HomeCubit>().state;
      if (currentState is HomeLoading) {
        showLoading();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _bannerType != null) {
      // User returned from Settings/GPS toggle — reload dashboard
      setState(() => _bannerType = null);
      context.read<HomeCubit>().loadDashboard();
    }
  }

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
              child: BlocListener<HomeCubit, HomeState>(
                listener: (context, state) {
                  if (state is HomeLoading) {
                    showLoading();
                  } else if (state is HomeLocationPermissionDenied) {
                    setState(() => _bannerType = HomeLocationBannerType.permissionDenied);
                  } else if (state is HomeLocationDeniedForever) {
                    setState(() => _bannerType = HomeLocationBannerType.deniedForever);
                  } else if (state is HomeLocationServiceDisabled) {
                    setState(() => _bannerType = HomeLocationBannerType.serviceDisabled);
                  } else if (state is HomeLoaded || state is HomeError) {
                    hideLoading();
                  }
                },
                child: Column(
                  children: [
                    if (_bannerType != null)
                      HomeLocationBanner(
                        type: _bannerType!,
                        onDismiss: () => setState(() => _bannerType = null),
                      ),
                    Expanded(
                      child: BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
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
            ),
          ],
        ),
      ),
    );
  }
}
