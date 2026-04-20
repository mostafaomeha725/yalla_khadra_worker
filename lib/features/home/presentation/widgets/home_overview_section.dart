import 'package:flutter/material.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';
import 'package:yallakhadra/features/home/presentation/constants/home_strings.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_stat_card.dart';

class HomeOverviewSection extends StatelessWidget {
  final int avgHours;
  final int completedCount;

  const HomeOverviewSection({
    super.key,
    required this.avgHours,
    required this.completedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          HomeStrings.overviewTitle,
          style: font20w700.copyWith(color: const Color(0xFF111827)),
        ),
        verticalSpacing(10),
        Row(
          children: [
            HomeStatCard(
              icon: Icons.trending_up_rounded,
              value: '${avgHours}h',
              label: HomeStrings.avgTimeLabel,
              iconBackground: const Color(0xFFA855F7),
            ),
            horizontalSpacing(10),
            HomeStatCard(
              icon: Icons.workspace_premium_rounded,
              value: '$completedCount',
              label: HomeStrings.completedLabel,
              iconBackground: const Color(0xFFF59E0B),
            ),
          ],
        ),
      ],
    );
  }
}
