import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/light_colors.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/app_date_time.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/app_brand_header.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_details_top_bar.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_image_slider_card.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_information_item.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_location_map_card.dart';
import 'package:yallakhadra/core/enums/waste_type.dart';
import 'package:yallakhadra/features/my_works/presentation/cubit/my_work_details/my_work_details_cubit.dart';
import 'package:yallakhadra/features/my_works/presentation/cubit/my_work_details/my_work_details_state.dart';

class MyWorkCompletedDetailsBody extends StatelessWidget {
  final int reportId;

  const MyWorkCompletedDetailsBody({super.key, required this.reportId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppLightColors.defaultBackground,
      child: SafeArea(
        child: Column(
          children: [
            const AppBrandHeader(),
            const Divider(height: 1, color: Color(0xFFE2E8F0)),
            HomeReportDetailsTopBar(title: 'Completed Work Details'),
            const Divider(height: 1, color: Color(0xFFE2E8F0)),
            Expanded(
              child: BlocBuilder<MyWorkDetailsCubit, MyWorkDetailsState>(
                builder: (context, state) {
                  if (state is MyWorkDetailsLoading ||
                      state is MyWorkDetailsInitial) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppLightColors.primary,
                      ),
                    );
                  }

                  if (state is MyWorkDetailsError) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.w),
                        child: AppText(
                          state.message,
                          style: font14w400.copyWith(
                            color: const Color(0xFF64748B),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  if (state is MyWorkDetailsLoaded) {
                    final details = state.details;
                    final List<String> beforeImages = details.images
                        .map((img) => img.url)
                        .toList();
                    final List<String> afterImages = details.cleanupImages
                        .map((img) => img.url)
                        .toList();

                    return SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(22.w, 16.h, 22.w, 130.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Success Banner ──
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 22.h,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF10B981), Color(0xFF059669)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 56.w,
                                  height: 56.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.25),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check_circle_rounded,
                                    size: 32.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                verticalSpacing(12),
                                AppText(
                                  'Successfully Completed!',
                                  style: font20w700.copyWith(
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                  alignment: AlignmentDirectional.center,
                                ),
                                verticalSpacing(4),
                                AppText(
                                  'Great job cleaning our environment',
                                  style: font14w400.copyWith(
                                    color: Colors.white.withValues(alpha: 0.85),
                                  ),
                                  textAlign: TextAlign.center,
                                  alignment: AlignmentDirectional.center,
                                ),
                              ],
                            ),
                          ),
                          verticalSpacing(16),

                          // ── Before Images ──
                          if (beforeImages.isNotEmpty) ...[
                            AppText(
                              'Before Images',
                              style: font14w700.copyWith(
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            verticalSpacing(8),
                            HomeReportImageSliderCard(imageUrls: beforeImages),
                            verticalSpacing(16),
                          ],

                          // ── After Cleanup Images ──
                          if (afterImages.isNotEmpty) ...[
                            AppText(
                              'After Cleanup Images',
                              style: font14w700.copyWith(
                                color: const Color(0xFF10B981),
                              ),
                            ),
                            verticalSpacing(8),
                            HomeReportImageSliderCard(imageUrls: afterImages),
                            verticalSpacing(16),
                          ],

                          // ── Cleanup Details ──
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 14.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  'Cleanup Details',
                                  style: font14w700.copyWith(
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                verticalSpacing(12),
                                HomeReportInformationItem(
                                  icon: Icons.location_on_outlined,
                                  iconColor: const Color(0xFF64748B),
                                  label: 'Location',
                                  value: details.address.trim().isEmpty
                                      ? 'Unknown location'
                                      : details.address,
                                ),
                                HomeReportInformationItem(
                                  icon: Icons.inventory_2_outlined,
                                  iconColor: const Color(0xFF64748B),
                                  label: 'Original Waste Type',
                                  value: WasteType.values
                                      .firstWhere(
                                        (e) => e.value == details.wasteType,
                                        orElse: () => WasteType.trash,
                                      )
                                      .label,
                                ),
                                if (details.finalWasteTypeName
                                    .trim()
                                    .isNotEmpty)
                                  HomeReportInformationItem(
                                    icon: Icons.recycling_rounded,
                                    iconColor: const Color(0xFF10B981),
                                    label: 'Final Waste Type',
                                    value: details.finalWasteTypeName,
                                  ),
                                if (details.finalWeightInKg > 0)
                                  HomeReportInformationItem(
                                    icon: Icons.monitor_weight_outlined,
                                    iconColor: const Color(0xFFF59E0B),
                                    label: 'Final Weight',
                                    value:
                                        '${details.finalWeightInKg.toStringAsFixed(1)} kg',
                                  ),
                                HomeReportInformationItem(
                                  icon: Icons.access_time_rounded,
                                  iconColor: const Color(0xFF6366F1),
                                  label: 'Completion Time',
                                  value: AppDateTime.timestampToFormatted(
                                    details.createdAt,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          verticalSpacing(16),

                          // ── Location Map ──
                          HomeReportLocationMapCard(
                            locationQuery: details.address,
                            latitude: details.latitude != 0
                                ? details.latitude
                                : null,
                            longitude: details.longitude != 0
                                ? details.longitude
                                : null,
                          ),
                        ],
                      ),
                    );
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
