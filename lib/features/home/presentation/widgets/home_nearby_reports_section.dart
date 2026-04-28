import 'package:flutter/material.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/core/widgets/pagination_widget.dart';
import 'package:yallakhadra/features/home/domain/entities/home_nearby_report_entity.dart';
import 'package:yallakhadra/features/home/presentation/constants/home_strings.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_nearby_report_card.dart';

class HomeNearbyReportsSection extends StatelessWidget {
  final List<HomeNearbyReportEntity> reports;

  const HomeNearbyReportsSection({super.key, required this.reports});

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
              child: AppText(
                HomeStrings.viewAll,
                style: font14w500.copyWith(color: const Color(0xFF10B981)),
              ),
            ),
          ],
        ),
        verticalSpacing(10),
        Column(
          children: reports
              .map((report) => HomeNearbyReportCard(report: report))
              .toList(),
        ),
        PaginationWidget(
          totalPages: 10,
          currentPage: 1,
          onPageChanged: (page) {},
        ),
      ],
    );
  }
}
