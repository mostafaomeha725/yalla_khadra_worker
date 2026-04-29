import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/utils/easy_loading.dart';
import 'package:yallakhadra/core/widgets/custom_loading.dart';
import 'package:yallakhadra/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:yallakhadra/features/reports/presentation/cubit/reports_state.dart';
import 'package:yallakhadra/features/reports/presentation/widgets/reports_filter_card.dart';
import 'package:yallakhadra/features/reports/presentation/widgets/reports_list_section.dart';
import 'package:yallakhadra/features/reports/presentation/widgets/reports_pagination_card.dart';
import 'package:yallakhadra/features/reports/presentation/widgets/reports_results_meta_row.dart';
import 'package:yallakhadra/features/reports/presentation/widgets/reports_section_header.dart';

class ReportsContentSection extends StatefulWidget {
  const ReportsContentSection({super.key});

  @override
  State<ReportsContentSection> createState() => _ReportsContentSectionState();
}

class _ReportsContentSectionState extends State<ReportsContentSection> {
  late final TextEditingController radiusController;
  ReportsLoaded? lastLoadedState;
  bool isApplyingFilter = false;

  @override
  void initState() {
    super.initState();
    radiusController = TextEditingController();
  }

  @override
  void dispose() {
    radiusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF3F4F6),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 120.h),
              child: BlocConsumer<ReportsCubit, ReportsState>(
                listener: (context, state) {
                  if (!isApplyingFilter) {
                    return;
                  }

                  if (state is ReportsLoading) {
                    showLoading(status: 'Applying filter...');
                  }

                  if (state is ReportsLoaded) {
                    hideLoading();
                    showSuccess('Filter applied successfully');
                    isApplyingFilter = false;
                  }

                  if (state is ReportsError) {
                    hideLoading();
                    showError(state.message);
                    isApplyingFilter = false;
                  }
                },
                builder: (context, state) {
                  if (state is ReportsLoaded) {
                    lastLoadedState = state;
                  }

                  if ((state is ReportsLoading || state is ReportsInitial) &&
                      lastLoadedState == null) {
                    return CustomLoading.showLoader();
                  }

                  final ReportsLoaded? loadedState = state is ReportsLoaded
                      ? state
                      : lastLoadedState;

                  if (loadedState == null) {
                    return const SizedBox();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ReportsSectionHeader(),
                      ReportsFilterCard(
                        radiusController: radiusController,
                        onApplyPressed: () {
                          isApplyingFilter = true;
                          context.read<ReportsCubit>().applyRadius(
                            radiusController.text,
                          );
                        },
                      ),
                      ReportsResultsMetaRow(
                        totalCount: loadedState.page.totalCount,
                      ),
                      ReportsListSection(reports: loadedState.page.reports),
                      ReportsPaginationCard(
                        currentPage: loadedState.page.currentPage,
                        totalPages: loadedState.page.totalPages,
                        hasPreviousPage: loadedState.page.hasPreviousPage,
                        hasNextPage: loadedState.page.hasNextPage,
                        onPreviousPressed: () {
                          context.read<ReportsCubit>().loadPreviousPage();
                        },
                        onNextPressed: () {
                          context.read<ReportsCubit>().loadNextPage();
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          verticalSpacing(6),
        ],
      ),
    );
  }
}
