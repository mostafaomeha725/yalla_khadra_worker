import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/di/services_locator.dart';
import 'package:yallakhadra/core/utils/easy_loading.dart';
import 'package:yallakhadra/features/ai_scan/presentation/cubit/ai_scan/ai_scan_cubit.dart';
import 'package:yallakhadra/features/ai_scan/presentation/cubit/ai_scan/ai_scan_state.dart';
import 'package:yallakhadra/features/ai_scan/presentation/widgets/ai_scan_action_cards_section.dart';
import 'package:yallakhadra/features/ai_scan/presentation/widgets/ai_scan_hero_section.dart';
import 'package:yallakhadra/features/ai_scan/presentation/widgets/ai_scan_previous_scans_section.dart';

class AiScanContentSection extends StatelessWidget {
  const AiScanContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AiScanCubit>(
      create: (_) => sl<AiScanCubit>()..fetchMyScans(),
      child: BlocListener<AiScanCubit, AiScanState>(
        listener: (BuildContext context, AiScanState state) {
          if (state is AiScanLoading) {
            showLoading(status: state.message, userInteractions: false);
          }

          if (state is AiScanLoaded) {
            hideLoading();
          }

          if (state is AiScanError) {
            hideLoading();
            showError(state.message);
          }

          if (state is AiScanSuccess) {
            hideLoading();
            showSuccess(state.message);
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(22.w, 10.h, 22.w, 110.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AiScanHeroSection(),
              SizedBox(height: 12.h),
              const AiScanActionCardsSection(),
              SizedBox(height: 12.h),
              const AiScanPreviousScansSection(),
            ],
          ),
        ),
      ),
    );
  }
}
