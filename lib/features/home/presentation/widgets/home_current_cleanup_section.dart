import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yallakhadra/core/routes/route_paths.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/app_image.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/home/domain/entities/home_cleanup_task_entity.dart';
import 'package:yallakhadra/features/home/presentation/constants/home_strings.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_info_row.dart';

class HomeCurrentCleanupSection extends StatelessWidget {
  final HomeCleanupTaskEntity task;

  const HomeCurrentCleanupSection({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          HomeStrings.currentCleanupTitle,
          style: font20w700.copyWith(color: const Color(0xFF111827)),
        ),
        verticalSpacing(10),
        BounceIt(
          onPressed: () {
            context.push(Routes.homeCurrentCleanupScreen, extra: task);
          },
          child: Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981),
              borderRadius: BorderRadius.circular(26.r),
              border: Border.all(color: const Color(0xFF34D399), width: 1.5),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x220F172A),
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppImage(
                  imageUrl: task.imageUrl,
                  width: 94.w,
                  height: 94.w,
                  fit: BoxFit.cover,
                  showprogressIndicator: false,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                horizontalSpacing(14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppText(
                              task.title,
                              maxLines: 3,
                              style: font18w700.copyWith(color: Colors.white),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFACC15),
                              borderRadius: BorderRadius.circular(999.r),
                            ),
                            child: AppText(
                              task.status,
                              style: font12w500.copyWith(
                                color: const Color(0xFF7B3306),
                              ),
                              alignment: AlignmentDirectional.center,
                            ),
                          ),
                        ],
                      ),
                      verticalSpacing(6),
                      HomeInfoRow(
                        icon: Icons.location_on_outlined,
                        value: task.distance,
                        iconColor: Colors.white,
                        textColor: const Color(0xFFE6FFFA),
                      ),
                      verticalSpacing(4),
                      HomeInfoRow(
                        icon: Icons.access_time_rounded,
                        value: task.timeAgo,
                        iconColor: Colors.white,
                        textColor: const Color(0xFFE6FFFA),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
