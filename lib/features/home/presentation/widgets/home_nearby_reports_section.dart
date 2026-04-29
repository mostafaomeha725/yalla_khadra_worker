import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/core/enums/waste_type.dart';
import 'package:yallakhadra/core/helpers/helpers.dart';
import 'package:yallakhadra/core/utils/easy_loading.dart';
import 'package:yallakhadra/core/widgets/custom_loading.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_nav_bar.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/reports/data/repositories/reports_repository_impl.dart';
import 'package:yallakhadra/features/reports/domain/usecases/get_nearby_reports_use_case.dart';
import 'package:yallakhadra/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:yallakhadra/features/reports/presentation/cubit/reports_state.dart';
import 'package:yallakhadra/features/home/presentation/constants/home_strings.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_nearby_report_card.dart';
import 'package:yallakhadra/features/home/domain/entities/home_nearby_report_entity.dart';

class HomeNearbyReportsSection extends StatelessWidget {
  const HomeNearbyReportsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportsCubit(
        GetNearbyReportsUseCase(ReportsRepositoryImpl()),
        useRadiusByDefault: false,
      )..loadReports(),
      child: BlocBuilder<ReportsCubit, ReportsState>(
        builder: (context, state) {
          if (state is ReportsLoading || state is ReportsInitial) {
            return CustomLoading.showLoader();
          }

          if (state is ReportsError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showError(state.message);
            });
            return AppText(state.message);
          }

          final ReportsLoaded loaded = state as ReportsLoaded;
          final List<HomeNearbyReportEntity> reports = loaded.page.reports
              .map(
                (report) => HomeNearbyReportEntity(
                  title: report.address,
                  distance: '',
                  timeAgo: Helpers.formatReportDate(report.createdAt),
                  wasteType: WasteType.values
                      .firstWhere(
                        (waste) => waste.value == report.wasteType,
                        orElse: () => WasteType.unknown,
                      )
                      .label,
                  imageUrl: report.imageUrl,
                  imageUrls: report.imageUrls,
                ),
              )
              .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    HomeStrings.nearbyReportsTitle,
                    style: font20w700.copyWith(color: const Color(0xFF111827)),
                  ),
                  BounceIt(
                    onPressed: () {
                      CustomNavBar.switchToTab(context, 1);
                    },
                    child: AppText(
                      HomeStrings.viewAll,
                      style: font14w500.copyWith(
                        color: const Color(0xFF10B981),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpacing(10),
              Column(
                children: List.generate(reports.length, (index) {
                  final report = reports[index];
                  final apiReport = loaded.page.reports[index];

                  return FutureBuilder<String>(
                    future: Helpers.formatDistanceFromCurrentLocation(
                      targetLatitude: apiReport.latitude,
                      targetLongitude: apiReport.longitude,
                    ),
                    builder: (context, snapshot) {
                      return HomeNearbyReportCard(
                        report: HomeNearbyReportEntity(
                          title: report.title,
                          distance:
                              snapshot.data ??
                              '${apiReport.latitude.toStringAsFixed(4)}, ${apiReport.longitude.toStringAsFixed(4)}',
                          timeAgo: report.timeAgo,
                          wasteType: report.wasteType,
                          imageUrl: report.imageUrl,
                          imageUrls: report.imageUrls,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              // ReportsPaginationCard(
              //   currentPage: loaded.page.currentPage,
              //   totalPages: loaded.page.totalPages,
              //   hasPreviousPage: loaded.page.hasPreviousPage,
              //   hasNextPage: loaded.page.hasNextPage,
              //   onPreviousPressed: () {
              //     context.read<ReportsCubit>().loadPreviousPage();
              //   },
              //   onNextPressed: () {
              //     context.read<ReportsCubit>().loadNextPage();
              //   },
              // ),
            ],
          );
        },
      ),
    );
  }
}
