import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yallakhadra/core/enums/waste_type.dart';
import 'package:yallakhadra/core/helpers/helpers.dart';
import 'package:yallakhadra/core/theme/light_colors.dart';
import 'package:yallakhadra/core/utils/easy_loading.dart';
import 'package:yallakhadra/core/widgets/app_brand_header.dart';
import 'package:yallakhadra/core/widgets/custom_button.dart';
import 'package:yallakhadra/features/home/domain/entities/home_cleanup_task_entity.dart';
import 'package:yallakhadra/features/home/domain/entities/home_nearby_report_entity.dart';
import 'package:yallakhadra/features/home/presentation/cubit/home_cubit.dart';
import 'package:yallakhadra/features/home/presentation/cubit/home_state.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_current_cleanup_location_details_card.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_location_map_card.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_current_cleanup_upload_proof_card.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_current_cleanup_waste_details_card.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_details_top_bar.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_image_slider_card.dart';

class HomeCurrentCleanupBody extends StatefulWidget {
  final HomeCleanupTaskEntity task;

  const HomeCurrentCleanupBody({super.key, required this.task});

  @override
  State<HomeCurrentCleanupBody> createState() => _HomeCurrentCleanupBodyState();
}

class _HomeCurrentCleanupBodyState extends State<HomeCurrentCleanupBody> {
  late final TextEditingController finalWeightController;
  final List<File> selectedProofImages = <File>[];
  WasteType? selectedWasteType;

  @override
  void initState() {
    super.initState();
    finalWeightController = TextEditingController();
  }

  @override
  void dispose() {
    finalWeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String locationQuery = widget.task.locationQuery.trim().isEmpty
        ? widget.task.title
        : widget.task.locationQuery;
    final HomeNearbyReportEntity report = HomeNearbyReportEntity(
      id: 0,
      title: '${widget.task.title} ${widget.task.subTitle}',
      distance: widget.task.distance.replaceAll(' away', ''),
      timeAgo: widget.task.timeAgo.replaceFirst('Taken ', ''),
      wasteType: widget.task.wasteType,
      imageUrl: widget.task.imageUrl,
      latitude: widget.task.latitude,
      longitude: widget.task.longitude,
    );

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeCleanupTaskCompleted) {
          hideLoading();
          showSuccess(state.message);
          context.pop(true);
        }
        if (state is HomeCleanupTaskCompleteError) {
          hideLoading();
          showError(state.message);
        }
      },
      builder: (context, state) {
        final bool isSubmitting = state is HomeCleanupTaskCompleting;
        if (isSubmitting) {
          showLoading();
        }
        return Container(
          width: double.infinity,
          color: AppLightColors.defaultBackground,
          child: SafeArea(
            child: Column(
              children: [
                const AppBrandHeader(),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                const HomeReportDetailsTopBar(title: 'Current Cleanup'),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 130.h),
                    child: Column(
                      children: [
                        HomeReportImageSliderCard(
                          imageUrls: widget.task.imageUrls.isEmpty
                              ? <String>[widget.task.imageUrl]
                              : widget.task.imageUrls,
                        ),
                        SizedBox(height: 12.h),
                        HomeCurrentCleanupLocationDetailsCard(
                          report: report,
                          locationQuery: locationQuery,
                        ),
                        SizedBox(height: 12.h),
                        HomeReportLocationMapCard(
                          locationQuery: locationQuery,
                          latitude: widget.task.latitude != 0 ? widget.task.latitude : null,
                          longitude: widget.task.longitude != 0 ? widget.task.longitude : null,
                        ),
                        SizedBox(height: 12.h),
                        HomeCurrentCleanupUploadProofCard(
                          onCameraPressed: () async {
                            final File? file =
                                await Helpers.pickImageFromCamera();
                            if (file == null) {
                              return;
                            }
                            setState(() {
                              selectedProofImages.add(file);
                            });
                          },
                          onGalleryPressed: () async {
                            final List<File> files = await Helpers.getImages();
                            if (files.isEmpty) {
                              return;
                            }
                            setState(() {
                              selectedProofImages.addAll(files);
                            });
                          },
                          selectedImagePaths: selectedProofImages
                              .map((File item) => item.path)
                              .toList(growable: false),
                          onRemoveImage: (int index) {
                            setState(() {
                              selectedProofImages.removeAt(index);
                            });
                          },
                        ),
                        SizedBox(height: 12.h),
                        HomeCurrentCleanupWasteDetailsCard(
                          selectedWasteType: selectedWasteType,
                          onWasteTypeChanged: (WasteType? value) {
                            setState(() {
                              selectedWasteType = value;
                            });
                          },
                          finalWeightController: finalWeightController,
                        ),
                        SizedBox(height: 12.h),
                        AppButton(
                          text: 'Complete Cleanup',
                          onPressed: isSubmitting
                              ? null
                              : () {
                                  final String weight = finalWeightController
                                      .text
                                      .trim();
                                  if (selectedWasteType == null ||
                                      weight.isEmpty) {
                                    showError(
                                      'Please enter waste type and weight.',
                                    );
                                    return;
                                  }
                                  if (selectedProofImages.isEmpty) {
                                    showError(
                                      'Please upload at least one proof image.',
                                    );
                                    return;
                                  }
                                  context.read<HomeCubit>().completeCleanupTask(
                                    taskId: widget.task.taskId,
                                    finalWasteType: selectedWasteType!.value,
                                    finalWeightInKg: weight,
                                    imagePaths: selectedProofImages
                                        .map((File item) => item.path)
                                        .toList(growable: false),
                                  );
                                },
                          color: const Color(0xFF10B981),
                          textColor: Colors.white,
                          textSize: 14.sp,
                          textWeight: FontWeight.w700,
                          radius: 10.r,
                          height: 52.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
